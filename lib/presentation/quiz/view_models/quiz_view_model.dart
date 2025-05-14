import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/answer_result.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/question.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/filter_extensions.dart';
import '../../../utilities/extensions/iterable_extensions.dart';
import '../../view_model.dart';

class QuizViewModel extends ViewModel {
  static final _logTag = (QuizViewModel).toString();

  final SharedPreferenceService preferenceService;

  QuizViewModel(this.preferenceService);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await preferenceService.initializationFuture;
    updateQuiz();
  }

  // Update & Notify
  List<Verb> _verbs = [];

  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    if (ListEquality().equals(_verbs, verbs)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }

    _verbs = verbs;
    debugPrint("$_logTag | Loaded Verbs Count: ${_verbs.length}");
    debugPrint("$_logTag | Loaded Verbs: ${_verbs.map((e) => e.italianInfinitive)}");

    // Create Quiz
    if(isInitialized) updateQuiz();
  }

  // Quizzable State
  final List<Verb> _quizzableVerbs = [];
  final List<ItalianTense> _quizzableTenses = [];
  final List<Pronoun> _quizzablePronouns = [];

  updateQuiz({bool skipQuestion = false}){
    debugPrint("$_logTag | updateQuiz() started");
    _findQuizzableVerbs();
    _findQuizzableTenses();
    _findQuizzablePronouns();

    // Current Question not Quizzable => Randomize
    if(!isCurrentQuestionQuizzable) {
      addAndResetQuestion(add: false);
      createNewQuestion();
    }
    debugPrint("$_logTag | updateQuiz() ended");
  }

  // Quiz State
  Question? _currentQuestion;
  final List<Question> _quizHistory = [];
  AnswerResult? _currentAnswerResult;
  AnswerResult? get currentAnswerResult => _currentAnswerResult;

  // Getters - Quiz State
  List<Question> get _negativeQuizHistory => _quizHistory.whereNot((quiz) => quiz.isCorrect).toList();
  List<Question> get _positiveQuizHistory => _quizHistory.where((quiz) => quiz.isCorrect).toList();
  int get negativeQuizCount => _negativeQuizHistory.length;
  int get positiveQuizCount => _positiveQuizHistory.length;
  int get totalQuizCount => _quizHistory.length;
  bool get hasQuizzableQuestions =>
      _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get hasCurrentQuestion => _currentQuestion != null;
  bool get usesEssere => _currentQuestion?.usesEssere ?? false;
  bool get usesPastParticiple => _currentQuestion?.usesPastParticiple ?? false;
  bool get hasCurrentAnswer => _currentQuestion?.answer != null;
  bool get isDoubleAuxiliary => _currentQuestion?.isDoubleAuxiliary ?? false;
  bool get hasTriesLeft => _currentQuestion?.hasTriesLeft ?? false;
  bool get isAnsweredCorrectly => _currentQuestion?.isCorrect ?? false;
  bool get isCurrentQuestionQuizzable {
    return _quizzableVerbs.contains(_currentQuestion?.verb) &&
        _quizzableTenses.contains(_currentQuestion?.tense.type) &&
        _quizzablePronouns.contains(_currentQuestion?.pronoun);
  }

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuestion?.currentTitle;
  String? get currentQuestion => _currentQuestion?.question;
  String? get currentTranslation => _currentQuestion?.translation;
  String? get currentSolution => _currentQuestion?.solution;
  String? get currentAuxiliaryLabel => _currentQuestion?.auxiliary.name.toUpperCase();

  void _findQuizzableVerbs() {
    debugPrint("$_logTag | _findQuizzableVerbs() started");
    List<Verb> verbs = _verbs;
    final favouriteFilter = preferenceService.loadVerbFavouriteFilter();
    switch (favouriteFilter) {
      case VerbFavouriteFilter.all:
        break;
      case VerbFavouriteFilter.starred:
        verbs = preferenceService.getStarredVerbsFrom(verbs);
        break;
    }
    if(verbs.isNotEmpty) {
      final endingFilter = preferenceService.loadVerbEndingFilter();
      verbs = verbs.where((verb) => endingFilter.includesVerb(verb)).toList();
    }
    // TODO in CON-57
    //final irregularityFilter = preferenceService.loadVerbIrregularityFilter();
    //verbs = verbs.where((verb) => irregularityFilter.includesVerb(verb)).toList();
    //final favouriteFilter = preferenceService.loadVerbFavouriteFilter();
    _quizzableVerbs.clear();
    _quizzableVerbs.addAll(verbs);
    debugPrint("$_logTag | Quizzable Verb Count: ${_quizzableVerbs.length}");
    debugPrint("$_logTag | _findQuizzableVerbs() ended");
  }

  void _findQuizzableTenses() {
    debugPrint("$_logTag | _findQuizzableTenses() started");
    final tenses = preferenceService.loadTenses();
    _quizzableTenses.clear();
    _quizzableTenses.addAll(ItalianTense.values.where((tense) => tenses.contains(tense)));
    debugPrint("$_logTag | Quizzable Tense Count: ${_quizzableTenses.length}");
    debugPrint("$_logTag | _findQuizzableTenses() ended");
  }

  void _findQuizzablePronouns() {
    debugPrint("$_logTag | _findQuizzablePronouns() started");
    final pronouns = preferenceService.loadPronouns();
    _quizzablePronouns.clear();
    _quizzablePronouns.addAll(Pronoun.values.where((pronoun) => pronouns.contains(pronoun)));
    debugPrint("$_logTag | Quizzable Pronoun Count: ${_quizzablePronouns.length}");
    debugPrint("$_logTag | _findQuizzablePronouns() ended");
  }

  createNewQuestion() {
    debugPrint("$_logTag | createNewQuestion() started");

    // Reset QuizValues
    if(hasCurrentQuestion) addAndResetQuestion();

    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    if (!hasQuizzableQuestions) {
      notifyListeners();
      if (_quizzableVerbs.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Verbs found");
      } else if (_quizzableTenses.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Tenses found");
      } else if (_quizzablePronouns.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Pronouns found");
      }
    }

    // Create NEW RANDOM Quiz Values
    _randomizeQuestion();

    while (currentSolution == null) {
      debugPrint("$_logTag | Re-Randomize Quiz Item");
      _randomizeQuestion();
    }

    // Check Previous Quiz
    if(_quizHistory.lastOrNull?.solution == _currentQuestion?.solution) {
      debugPrint("$_logTag | Question again the same");
      _randomizeQuestion();
    }

    debugPrint("$_logTag | Solution: ${_currentQuestion?.solutionExtended}");

    notifyListeners();
    debugPrint("$_logTag | createNewQuestion() ended");
  }

  void _randomizeQuestion() {
    debugPrint("$_logTag | _randomizeQuestion()");
    final currentPronoun = _quizzablePronouns.randomElement;
    debugPrint("$_logTag | Current Pronoun: ${currentPronoun.name}");
    final currentVerb = _quizzableVerbs.randomElementOrNull;
    debugPrint("$_logTag | Current Verb: ${currentVerb?.italianInfinitive}");
    if (currentVerb == null) return;
    final currentAuxiliary = currentVerb.auxiliaries.randomElement;
    debugPrint("$_logTag | Current Auxiliary: ${currentAuxiliary.name}");
    final quizzableTense = currentVerb.getTense(_quizzableTenses.randomElement)(currentAuxiliary);
    debugPrint("$_logTag | Current Tense: ${quizzableTense.type.name}");
    _currentQuestion = Question(
      verb: currentVerb,
      auxiliary: currentAuxiliary,
      tense: quizzableTense,
      pronoun: currentPronoun,
    );
  }

  void addAndResetQuestion({bool add = true}){
    if(_currentQuestion case var question?) {
      if(add) {
        if (question.hasTriesLeft) {
          // Question not Finished
          debugPrint("$_logTag | Add Question to history");
          _quizzablePronouns.contains(question.pronoun);
          _quizzableVerbs.contains(question.verb);
          _quizzableTenses.contains(question.tense.type);
          _quizHistory.add(_currentQuestion!);
          debugPrint("$_logTag | QuizHistory has this many items: ${_quizHistory.length}");
        } else {
          // Question Done
          debugPrint("$_logTag | Add Question to history");
          _quizHistory.add(question);
          debugPrint("$_logTag | QuizHistory has this many items: ${_quizHistory.length}");
        }
      }
      debugPrint("$_logTag | Reset Quiz Values");
      _currentQuestion = null;
      _currentAnswerResult = null;
    }
  }

  void checkAnswer(String answer){
    // Null safety
    if (_currentQuestion case var question?) {
      final result = question.checkAnswer(answer);
      debugPrint("$_logTag | ${result.message}");
      _currentAnswerResult = result;
      notifyListeners();
    }
  }
}
