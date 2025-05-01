import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../main.dart';
import '../../../data/enums/answer_result.dart';
import '../../../data/enums/pronoun.dart';
import '../../../domain/models/quiz_item.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../data/models/verb.dart';
import '../../../utilities/extensions/iterable_extensions.dart';
import '../../../domain/view_model.dart';

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
    // TODO Without using verbs
    updateQuizzable();

    // Random
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
    _quizzableTenses.addAll(ItalianTense.values.where((tense) => tensePrefs.contains(tense.prefKey)));
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

    // Reset QuizValues
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
      final result = quizItem.checkAnswer(answer);
      debugPrint("$_logTag | ${result.message}");
      _currentAnswerResult = result;
      notifyListeners();
    }
  }
}
