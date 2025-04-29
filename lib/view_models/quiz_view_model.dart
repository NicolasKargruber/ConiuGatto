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
import '../models/quizzable_tense.dart';
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
    if(ListEquality().equals(_verbs, verbs)) {
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

  _initializeQuizzable(){
    _findQuizzableVerbs();
    _findQuizzableTenses();
    _findQuizzablePronouns();
  }

  // TODO Move to QuizItem
  Verb? _currentVerb;
  Auxiliary? currentAuxiliary;
  QuizItem? _currentQuizItem;
  Pronoun? _currentPronoun;
  String? _currentAnswer;

  // Getters - Quiz State
  String? get currentSolution => _currentQuizItem?.solution;
  // TODO Move to quizItem
  bool get isDoubleAuxiliary => _currentQuizItem?.verb.isDoubleAuxiliary ?? false;
  bool get hasQuizzableItems => _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get usesEssere => _currentQuizItem?.auxiliary.requiresGenderedParticiple ?? false;
  bool get usesPastParticiple => _currentQuizItem?.tense.usesPastParticiple ?? false;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuizItem?.currentTitle;
  String? get currentQuestion => _currentQuizItem?.question;
  String? get currentTranslation => _currentQuizItem?.translation;

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
      final tense = IndicativeTense.values.firstWhereOrNull((tense) => tense.prefKey == prefKey) ??
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
    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    if(!hasQuizzableItems) {
      notifyListeners();
      if (_quizzableVerbs.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Verbs found");
      } else if (_quizzableTenses.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Tenses found");
      } else if (_quizzablePronouns.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Pronouns found");
      }
    }

    _randomizeQuizItem();

    while (currentSolution == null){
      debugPrint("$_logTag | Re-Randomize Quiz Item");
      _randomizeQuizItem();

      // TODO check for previous Quiz being the same
      /*final newQuizzableTense = _quizzableTenses.randomElementOrNull;
      if(newQuizzableTense == _currentQuizzableTense) {
        debugPrint("$_logTag | QuizzableTense is still the same");
        continue;
      }
      _currentQuizzableTense = newQuizzableTense;*/
    }

    debugPrint("$_logTag | Current Verb: ${_currentVerb?.italianInfinitive}");
    debugPrint("$_logTag | Solution: (${_currentPronoun?.italian}) $currentSolution");

    notifyListeners();
    debugPrint("$_logTag | createNewQuizItem() ended");
  }

  void _randomizeQuizItem() {
    _currentVerb = _quizzableVerbs.randomElementOrNull;
    currentAuxiliary = _currentVerb?.auxiliaries.randomElementOrNull;
    _currentPronoun = _quizzablePronouns.randomElementOrNull;
    final quizzableTense = _currentVerb?.getTense(_quizzableTenses.randomElement)(currentAuxiliary!);
    if(hasQuizzableItems && quizzableTense != null) _currentQuizItem = QuizItem(verb: _currentVerb!, auxiliary: currentAuxiliary!, tense: quizzableTense, pronoun: _currentPronoun!);
  }

  // TODO Move to QuizItem
  AnswerResult isAnswerCorrect(String answer) {
    debugPrint("$_logTag | isAnswerCorrect()");
    _currentAnswer = answer;

    // Add Gender to Participle if necessary
    if (usesEssere && usesPastParticiple) {
      _currentAnswer = _currentPronoun?.genderItalianConjugationIfPossible(answer);
      debugPrint("$_logTag | Gendered Answer : $_currentAnswer");
    }

    // Correct
    if (_currentAnswer == currentSolution) return AnswerResult.correct;

    // Missing Accents
    if (_currentAnswer == currentSolution?.removeDiacritics()) return AnswerResult.missingAccents;
    debugPrint("$_logTag | Solution without Accents: ${currentSolution?.removeDiacritics()}");

    // Missing a letter
    final differences = currentSolution?.diff(_currentAnswer ?? '') ?? [];
    if(differences.isNotEmpty) {
      // Print Differences
      printDifferences(differences);

      // 1 Letter Away
      if(_currentAnswer?.levenshteinDistance(currentSolution ?? '') == 1) {
        return AnswerResult.almostCorrect;
      }

      // Force Gendered Participle
      if(_currentPronoun?.genderItalianConjugationIfPossible(answer, forceGender: true) == currentSolution) {
        return AnswerResult.almostCorrect;
      }
    }

    // Incorrect
    return AnswerResult.incorrect;
  }

  printDifferences(List<Difference> differences) {
    debugPrint("$_logTag | printDifferences() started");
    for (final difference in differences) {
      debugPrint("$_logTag | Difference at index ${difference.index}: '${difference.$1}' vs '${difference.$2}'");
    }
    debugPrint("$_logTag | printDifferences() ended");
  }
}
