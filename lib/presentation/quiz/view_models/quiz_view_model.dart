import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../main.dart';
import '../../../domain/models/answer_result.dart';
import '../../../data/enums/pronoun.dart';
import '../../../domain/models/quiz_item.dart';
import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/verb.dart';
import '../../../utilities/extensions/iterable_extensions.dart';
import '../../view_model.dart';

final _logTag = (QuizViewModel).toString();

class QuizViewModel extends ViewModel {

  final SharedPreferenceService preferenceService;

  QuizViewModel(this.preferenceService);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await preferenceService.initializationFuture;
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

    // Find Quizzable
    // TODO One triggers the other conditionally and vice versa
    updateQuizzable();

    // Random
    // TODO One triggers the other conditionally and vice versa
    createNewQuizItem();
  }

  // TODO update when new prefs come in

  // Quizzable State
  final List<Verb> _quizzableVerbs = [];
  final List<ItalianTense> _quizzableTenses = [];
  final List<Pronoun> _quizzablePronouns = [];

  updateQuizzable() {
    _findQuizzableVerbs();
    _findQuizzableTenses();
    _findQuizzablePronouns();
  }

  // Quiz State
  QuizItem? _currentQuizItem;
  final List<QuizItem> _quizHistory = [];
  AnswerResult? _currentAnswerResult;
  AnswerResult? get currentAnswerResult => _currentAnswerResult;

  // Getters - Quiz State
  List<QuizItem> get _negativeQuizHistory => _quizHistory.whereNot((quiz) => quiz.isCorrect).toList();
  List<QuizItem> get _positiveQuizHistory => _quizHistory.where((quiz) => quiz.isCorrect).toList();
  int get negativeQuizCount => _negativeQuizHistory.length;
  int get positiveQuizCount => _positiveQuizHistory.length;
  int get totalQuizCount => _quizHistory.length;
  bool get hasQuizzableItems =>
      _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get usesEssere => _currentQuizItem?.usesEssere ?? false;
  bool get usesPastParticiple => _currentQuizItem?.usesPastParticiple ?? false;
  bool get hasCurrentAnswer => _currentQuizItem?.answer != null;
  bool get isDoubleAuxiliary => _currentQuizItem?.isDoubleAuxiliary ?? false;
  bool get hasTriesLeft => _currentQuizItem?.hasTriesLeft ?? false;
  bool get isAnsweredCorrectly => _currentQuizItem?.isCorrect ?? false;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuizItem?.currentTitle;
  String? get currentQuestion => _currentQuizItem?.question;
  String? get currentTranslation => _currentQuizItem?.translation;
  String? get currentSolution => _currentQuizItem?.solution;
  String? get currentAuxiliaryLabel => _currentQuizItem?.auxiliary.name.toUpperCase();

  void _findQuizzableVerbs() {
    debugPrint("$_logTag | _findQuizzableVerbs() started");
    List<Verb> verbs = _verbs;
    final endingFilter = preferenceService.loadVerbEndingFilter();
    verbs = verbs.where((verb) => endingFilter.includesVerb(verb)).toList();
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

  createNewQuizItem() {
    debugPrint("$_logTag | createNewQuizItem() started");

    // Reset QuizValues
    resetQuizItem();

    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    if (!hasQuizzableItems) {
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
    _randomizeQuizItem();

    while (currentSolution == null) {
      debugPrint("$_logTag | Re-Randomize Quiz Item");
      _randomizeQuizItem();
    }

    // Check Previous Quiz
    if(_quizHistory.lastOrNull?.solution == _currentQuizItem?.solution) {
      debugPrint("$_logTag | QuizItem again the same");
      _randomizeQuizItem();
    }

    debugPrint("$_logTag | Solution: ${_currentQuizItem?.solutionExtended}");

    notifyListeners();
    debugPrint("$_logTag | createNewQuizItem() ended");
  }

  void _randomizeQuizItem() {
    final currentPronoun = _quizzablePronouns.randomElement;
    debugPrint("$_logTag | Current Pronoun: ${currentPronoun.name}");
    final currentVerb = _quizzableVerbs.randomElementOrNull;
    debugPrint("$_logTag | Current Verb: ${currentVerb?.italianInfinitive}");
    if (currentVerb == null) return;
    final currentAuxiliary = currentVerb.auxiliaries.randomElement;
    debugPrint("$_logTag | Current Auxiliary: ${currentAuxiliary.name}");
    final quizzableTense = currentVerb.getTense(_quizzableTenses.randomElement)(currentAuxiliary);
    debugPrint("$_logTag | Current Tense: ${quizzableTense.type.name}");
    _currentQuizItem = QuizItem(
      verb: currentVerb,
      auxiliary: currentAuxiliary,
      tense: quizzableTense,
      pronoun: currentPronoun,
    );
  }

  void resetQuizItem(){
    if(_currentQuizItem case var quizItem?) {
      if(quizItem.hasTriesLeft){
        // QuizItem not Finished
        debugPrint("$_logTag | Add QuizItem to history");
        _quizzablePronouns.contains(quizItem.pronoun);
        _quizzableVerbs.contains(quizItem.verb);
        _quizzableTenses.contains(quizItem.tense.type);
        _quizHistory.add(_currentQuizItem!);
        debugPrint("$_logTag | QuizHistory has this many items: ${_quizHistory.length}");
      } else {
        // QuizItem Done
        debugPrint("$_logTag | Add QuizItem to history");
        _quizHistory.add(quizItem);
        debugPrint("$_logTag | QuizHistory has this many items: ${_quizHistory.length}");
      }
      debugPrint("$_logTag | Reset Quiz Values");
      _currentQuizItem = null;
      _currentAnswerResult = null;
    }
  }

  void checkAnswer(String answer){
    // Null safety
    if (_currentQuizItem case var quizItem?) {
      final result = quizItem.checkAnswer(answer);
      debugPrint("$_logTag | ${result.message}");
      _currentAnswerResult = result;
      notifyListeners();
    }
  }
}
