import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/shared_preference_keys.dart';
import '../main.dart';
import '../models/answer_result.dart';
import '../models/auxiliary.dart';
import '../models/pronoun.dart';
import '../models/quizzable_tense.dart';
import '../models/verb.dart';
import '../utilities/extensions/iterable_extensions.dart';
import '../utilities/extensions/string_extensions.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  final _logTag = (QuizViewModel).toString();

  // Shared Preferences
  // SharedPreferences? _prefs;
  Set<String> _tensePrefs = {};
  Set<String> _verbPrefs = {};
  Set<String> _pronounPrefs = {};

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    // _prefs = await SharedPreferences.getInstance();
    createQuizItem();
  }

  // Update & Notify
  List<Verb> _verbs = [];
  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    Function eq = const ListEquality().equals;
    if(eq(_verbs, verbs)) return debugPrint("$_logTag | loaded verbs are still the same");
    _verbs = verbs;
    //notifyListeners();
    createQuizItem();
  }

  // Quizzable State
  Verb? _currentVerb;
  final List<Verb> _quizzableVerbs = [];
  final List<QuizzableTense> _quizzableTenses = [];
  QuizzableTense? _currentQuizzableTense;
  final List<Pronoun> _quizzablePronouns = [];
  Pronoun? _currentPronoun;
  String? _currentAnswer;

  // Getters - Quiz State
  String? get currentSolution => _currentQuizzableTense?.solution(_currentPronoun);
  Auxiliary? get currentAuxiliary => _currentQuizzableTense?.auxiliary;
  bool get isDoubleAuxiliary => _currentQuizzableTense?.verb.isDoubleAuxiliary ?? false;
  bool get hasQuizzableItems => _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;
  bool get usesEssere => _currentQuizzableTense?.auxiliary.requiresGenderedParticiple ?? false;
  bool get usesPastParticiple => _currentQuizzableTense?.tense.usesPastParticiple ?? false;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuizzableTense?.currentTitle;
  String? get currentQuestion => _currentQuizzableTense?.question(_currentPronoun);
  String? get currentTranslation => _currentQuizzableTense?.translation(_currentPronoun);

  void _findQuizzableVerbs() {
    debugPrint("$_logTag | _findQuizzableVerbs() started");
    _verbPrefs = preferenceManager.loadVerbPrefs(_verbs.map((e) => e.prefKey));
    _quizzableVerbs.clear();
    _quizzableVerbs.addAll(_verbs.where((verb) => _verbPrefs.contains(verb.prefKey)));
    debugPrint("$_logTag | Quizzable Verb Count: ${_quizzableVerbs.length}");
    debugPrint("$_logTag | _findQuizzableVerbs() ended");
  }

  void _findQuizzableTenses() {
    debugPrint("$_logTag | _findQuizzableTenses() started");
    _tensePrefs = preferenceManager.loadTensePrefs();
    _quizzableTenses.clear();

    if (_currentVerb == null) {
      return debugPrint("$_logTag | No current Verb -> Cannot find QuizzableTenses");
    }

    for (final auxiliary in _currentVerb!.auxiliaries) {
      for (final mood in _currentVerb!.moods) {
        final tenses = mood.getTenses(auxiliary);
        for (final tense in tenses) {
          final prefKey = tense.runtimeType.toString();
          if (!_tensePrefs.contains(prefKey)) continue;
          final quizzableTense = QuizzableTense(verb: _currentVerb!, auxiliary: auxiliary, mood: mood, tense: tense);
          if(quizzableTense.hasConjugatedVerbs) _quizzableTenses.add(quizzableTense);
        }
      }
    }

    debugPrint("$_logTag | QuizzableTense Count: ${_quizzableTenses.length}");
    debugPrint("$_logTag | _findQuizzableTenses() ended");
  }

  void _findQuizzablePronouns() {
    debugPrint("$_logTag | _findQuizzablePronouns() started");
    _pronounPrefs = preferenceManager.loadPronounPrefs();
    _quizzablePronouns.clear();
    _quizzablePronouns.addAll(Pronoun.values.where((pronoun) => _pronounPrefs.contains(pronoun.prefKey)));
    debugPrint("$_logTag | Quizzable Pronoun Count: ${_quizzablePronouns.length}");
    debugPrint("$_logTag | _findQuizzablePronouns() ended");
  }

  createQuizItem() {
    debugPrint("$_logTag | createQuizItem() started");
    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    // Find Quizzable Verb
    _findQuizzableVerbs();
    _currentVerb = _quizzableVerbs.randomElementOrNull;

    // Find Quizzable Tense, Pronoun & Solution
    _findQuizzableTenses();
    _findQuizzablePronouns();
    _randomizeQuizItem();

    if(!hasQuizzableItems) {
      notifyListeners();
      if (_quizzableVerbs.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Verbs found");
      } else if (_quizzableTenses.isEmpty) {
        return debugPrint("$_logTag | No QuizzableTenses found");
      } else if (_quizzablePronouns.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Pronouns found");
      }
    }

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

    debugPrint("$_logTag | Current Verb: ${_currentVerb?.infinitive}");
    debugPrint("$_logTag | Solution: (${_currentPronoun?.italian}) $currentSolution");

    notifyListeners();
    debugPrint("$_logTag | createQuizItem() ended");
  }

  void _randomizeQuizItem() {
    _currentVerb = _quizzableVerbs.randomElementOrNull;
    _currentQuizzableTense = _quizzableTenses.randomElementOrNull;
    _currentPronoun = _quizzablePronouns.randomElementOrNull;
  }

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
      if(_currentAnswer?.levenshteinDistance(currentSolution ?? '') == 1)
        return AnswerResult.almostCorrect;

      // Force Gendered Participle
      if(_currentPronoun?.genderItalianConjugationIfPossible(answer, forceGender: true) == currentSolution)
        return AnswerResult.almostCorrect;
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
