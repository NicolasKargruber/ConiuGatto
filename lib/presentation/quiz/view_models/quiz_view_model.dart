import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/answer_result.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/question.dart';
import '../../../domain/models/quizzed_question.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/history_service.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/filter_extensions.dart';
import '../../../domain/utils/url_helper.dart';
import '../../../utilities/extensions/iterable_extensions.dart';
import '../../view_model.dart';

class QuizViewModel extends ViewModel {
  static final _logTag = (QuizViewModel).toString();

  final HistoryService _historyService;
  final List<QuizzedQuestion> _quizzableQuestions;
  final int quizLength;

  QuizViewModel(this._historyService,
      {required List<QuizzedQuestion> quizzableQuestions, required this.quizLength})
      : _quizzableQuestions = quizzableQuestions;

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    // Randomize
    //_quizzableQuestions.shuffle();
    updateQuiz();
    debugPrint("$_logTag | initialize() ended");
  }

  // Update & Notify
  List<Verb> _verbs = [];

  updateVerbs(List<Verb> verbs) async {
    if(!isInitialized) await initializationFuture;

    debugPrint("$_logTag | updateVerbs()");
    if (ListEquality().equals(_verbs, verbs)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }

    _verbs = verbs;
    debugPrint("$_logTag | Loaded Verbs Count: ${_verbs.length}");
    debugPrint("$_logTag | Loaded Verbs: ${_verbs.map((e) => e.italianInfinitive)}");

    // Create Quiz
    if(isInitialized) updateQuiz();
    debugPrint("$_logTag | initialized: ${isInitialized.toString()}");
    debugPrint("$_logTag | updateVerbs() ended");
  }

  updateQuiz(){
    debugPrint("$_logTag | updateQuiz() started");
    //_findQuizzableVerbs();
    //_findQuizzableTenses();
    //_findQuizzablePronouns();

    // Current Question not Quizzable => Randomize
    if(_verbs.isNotEmpty) {
      addAndResetQuestion(add: false);
      createNewQuestion();
    }
    debugPrint("$_logTag | updateQuiz() ended");
  }

  // Quiz State
  Question? _currentQuestion;
  final List<Question> _quizHistory = [];
  List<Question> get quizHistory => _quizHistory;
  AnswerResult? _currentAnswerResult;
  AnswerResult? get currentAnswerResult => _currentAnswerResult;

  // Getters - Quiz State
  List<Question> get _negativeQuizHistory => _quizHistory.whereNot((quiz) => quiz.isCorrect).toList();
  List<Question> get _positiveQuizHistory => _quizHistory.where((quiz) => quiz.isCorrect).toList();
  int get negativeQuizCount => _negativeQuizHistory.length;
  int get positiveQuizCount => _positiveQuizHistory.length;
  bool get hasCorrectAnswer => _currentAnswerResult == AnswerResult.correct;
  int get totalQuizCount => _quizHistory.length;
  //bool get hasQuizzableQuestions => _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get hasCurrentQuestion => _currentQuestion != null;
  bool get usesEssere => _currentQuestion?.usesEssere ?? false;
  bool get usesPastParticiple => _currentQuestion?.usesPastParticiple ?? false;
  bool get hasCurrentAnswer => _currentQuestion?.answer != null;
  bool get isDoubleAuxiliary => _currentQuestion?.isDoubleAuxiliary ?? false;
  bool get hasTriesLeft => _currentQuestion?.hasTriesLeft ?? false;
  bool get isAnsweredCorrectly => _currentQuestion?.isCorrect ?? false;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuestion?.currentTitle;
  String? get currentQuestionLabel => _currentQuestion?.question;
  String? get currentTranslation => _currentQuestion?.translation;
  String? get currentSolution => _currentQuestion?.solution;
  String? get currentAuxiliaryLabel => _currentQuestion?.auxiliary.name.toUpperCase();

  createNewQuestion() {
    debugPrint("$_logTag | createNewQuestion() started");

    // Reset QuizValues
    if(hasCurrentQuestion) addAndResetQuestion();

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
    final currentPronoun = _quizzableQuestions[_quizHistory.length].pronoun;
    debugPrint("$_logTag | Current Pronoun: ${currentPronoun.name}");
    final currentVerb = _verbs.firstWhereOrNull((verb) => verb.id == _quizzableQuestions[_quizHistory.length].verbID);
    debugPrint("$_logTag | Current Verb: ${currentVerb?.italianInfinitive}");
    if (currentVerb == null) return;
    final currentAuxiliary = _quizzableQuestions[_quizHistory.length].auxiliary;
    debugPrint("$_logTag | Current Auxiliary: ${currentAuxiliary.name}");
    final quizzableTense = _quizzableQuestions[_quizHistory.length].tense;
    debugPrint("$_logTag | Current Tense: ${quizzableTense.name}");
    _currentQuestion = Question(
      verb: currentVerb,
      auxiliary: currentAuxiliary,
      tense: currentVerb.getTense(quizzableTense)(currentAuxiliary),
      pronoun: currentPronoun,
    );
  }

  void addAndResetQuestion({bool add = true}){
    debugPrint("$_logTag | addAndResetQuestion(add:$add)");
    if(_currentQuestion case var question?) {
      if(add) {
        _addQuestionToHistory(question);
      }
      debugPrint("$_logTag | Reset Quiz Values");
      _currentQuestion = null;
      _currentAnswerResult = null;
    }
  }

  void _addQuestionToHistory(Question question){
    debugPrint("$_logTag | _addQuestionToHistory()");
    _quizHistory.add(question);
    debugPrint("$_logTag | QuizHistory has this many items: ${_quizHistory.length}");
    _historyService.addQuestion(question);
    notifyListeners();
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

  void reportSolution() {
    debugPrint("$_logTag | reportSolution()");
    UrlHelper.sendMailToReportSolution(
        _currentQuestion?.verb.italianInfinitive ?? "",
        _currentQuestion?.tense.extendedLabel ?? "",
        _currentQuestion?.solutionExtended ?? "",
    );
  }
}
