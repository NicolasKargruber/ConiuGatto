import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';
import '../models/answer_result.dart';
import '../models/auxiliary.dart';
import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/pronoun.dart';
import '../models/quiz_item.dart';
import '../models/tenses/tense.dart';
import '../models/verb.dart';
import '../utilities/extensions/iterable_extensions.dart';
import '../utilities/extensions/string_extensions.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  final _logTag = (QuizViewModel).toString();

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
  }

  // Update & Notify
  List<Verb> _verbs = [];

  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    if (ListEquality().equals(_verbs, verbs)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }
    _verbs = verbs;

    // Find Quizzable
    _initializeQuizzable();

    // Random
    createNewQuizItem();
  }

  // Quizzable State
  final List<Verb> _quizzableVerbs = [];
  final List<Enum> _quizzableTenses = [];
  final List<Pronoun> _quizzablePronouns = [];

  _initializeQuizzable() {
    _findQuizzableVerbs();
    _findQuizzableTenses();
    _findQuizzablePronouns();
  }

  // Quiz State
  QuizItem? _currentQuizItem;
  final List<QuizItem> _quizHistory = [];

  // Getters - Quiz State
  List<QuizItem> get _negativeQuizHistory => _quizHistory.where((quiz) => quiz.answerResult?.isCorrect == false).toList();
  List<QuizItem> get _positiveQuizHistory => _quizHistory.where((quiz) => quiz.answerResult?.isCorrect == true).toList();
  int get negativeQuizCount => _negativeQuizHistory.length;
  int get positiveQuizCount => _positiveQuizHistory.length;
  int get totalQuizCount => _quizHistory.length;
  bool get hasQuizzableItems =>
      _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get usesEssere => _currentQuizItem?.usesEssere ?? false;
  bool get usesPastParticiple => _currentQuizItem?.usesPastParticiple ?? false;
  bool get hasCurrentAnswer => _currentQuizItem?.answer != null;
  bool get isDoubleAuxiliary => _currentQuizItem?.isDoubleAuxiliary ?? false;
  AnswerResult? get currentAnswerResult => _currentQuizItem?.answerResult;
  bool get hasTriesLeft => _currentQuizItem?.hasTriesLeft ?? false;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuizItem?.currentTitle;
  String? get currentQuestion => _currentQuizItem?.question;
  String? get currentTranslation => _currentQuizItem?.translation;
  String? get currentSolution => _currentQuizItem?.solution;
  String? get currentAuxiliaryLabel => _currentQuizItem?.auxiliary.name.toUpperCase();

  void _findQuizzableVerbs() {
    debugPrint("$_logTag | _findQuizzableVerbs() started");
    final verbPrefs = preferenceManager.loadVerbPrefs(_verbs.map((e) => e.prefKey));
    _quizzableVerbs.clear();
    _quizzableVerbs.addAll(_verbs.where((verb) => verbPrefs.contains(verb.prefKey)));
    debugPrint("$_logTag | Quizzable Verb Count: ${_quizzableVerbs.length}");
    debugPrint("$_logTag | _findQuizzableVerbs() ended");
  }

  void _findQuizzableTenses() {
    debugPrint("$_logTag | _findQuizzableTenses() started");
    final tensePrefs = preferenceManager.loadTensePrefs();
    _quizzableTenses.clear();

    for (final prefKey in tensePrefs) {
      final tense =
          IndicativeTense.values.firstWhereOrNull((tense) => tense.prefKey == prefKey) ??
          ConditionalTense.values.firstWhereOrNull((tense) => tense.prefKey == prefKey) ??
          SubjunctiveTense.values.firstWhereOrNull((tense) => tense.prefKey == prefKey) ??
          ImperativeTense.values.firstWhereOrNull((tense) => tense.prefKey == prefKey);
      if (tense != null) _quizzableTenses.add(tense);
    }

    debugPrint("$_logTag | Quizzable Tense Count: ${_quizzableTenses.length}");
    debugPrint("$_logTag | _findQuizzableTenses() ended");
  }

  void _findQuizzablePronouns() {
    debugPrint("$_logTag | _findQuizzablePronouns() started");
    final pronounPrefs = preferenceManager.loadPronounPrefs();
    _quizzablePronouns.clear();
    _quizzablePronouns.addAll(Pronoun.values.where((pronoun) => pronounPrefs.contains(pronoun.prefKey)));
    debugPrint("$_logTag | Quizzable Pronoun Count: ${_quizzablePronouns.length}");
    debugPrint("$_logTag | _findQuizzablePronouns() ended");
  }

  createNewQuizItem() {
    debugPrint("$_logTag | createNewQuizItem() started");
    if(_currentQuizItem != null) {
      _quizHistory.add(_currentQuizItem!);
      _currentQuizItem = null;
    }

    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    if (!hasQuizzableItems) {
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

    debugPrint("$_logTag | Current Verb: ${_currentQuizItem?.verb.italianInfinitive}");
    debugPrint("$_logTag | Solution: ${_currentQuizItem?.solutionExtended}");

    notifyListeners();
    debugPrint("$_logTag | createNewQuizItem() ended");
  }

  void _randomizeQuizItem() {
    final currentPronoun = _quizzablePronouns.randomElement;
    final currentVerb = _quizzableVerbs.randomElementOrNull;
    if (currentVerb == null) return;
    final currentAuxiliary = currentVerb.auxiliaries.randomElement;
    final quizzableTense = currentVerb.getTense(_quizzableTenses.randomElement)(currentAuxiliary);
    _currentQuizItem = QuizItem(
      verb: currentVerb,
      auxiliary: currentAuxiliary,
      tense: quizzableTense,
      pronoun: currentPronoun,
    );
  }

  void checkAnswer(String answer){
    // Null safety
    if (_currentQuizItem case var quizItem?) {
      quizItem.checkAnswer(answer);
      // Null safety
      if (quizItem.answerResult case var result?) {
          debugPrint("$_logTag | ${result.message}");
      }
    }
  }
}
