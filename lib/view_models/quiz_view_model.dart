import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/shared_preference_keys.dart';
import '../models/auxiliary.dart';
import '../models/pronoun.dart';
import '../models/quizzable_tense.dart';
import '../models/verb.dart';
import '../utilities/extensions/string_extensions.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  // Update & Notify
  List<Verb> _verbs = [];

  // Shared Preferences
  SharedPreferences? prefs;
  Set<String> _tensePrefs = {};
  Set<String> _verbPrefs = {};

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("QuizViewModel | initialize()");
    prefs = await SharedPreferences.getInstance();
    randomizeVerb();
  }

  // Quizzable Items
  final List<Verb> _quizzableVerbs = [];
  final List<QuizzableTense> _quizzableTenses = [];
  QuizzableTense? _currentQuizzableTense;
  Verb? _currentVerb;
  Pronoun _currentPronoun = Pronoun.firstSingular;

  // Quiz Values
  String? get _currentSolution => _currentQuizzableTense?.solution(_currentPronoun);
  String? _currentAnswer;
  String? get _currentVerbPrefKey => _currentQuizzableTense?.verb.prefKey;
  String? get _currentTensePrefKey => _currentQuizzableTense?.tense.prefKey;
  bool get hasQuizzableTenses => _quizzableTenses.isNotEmpty;
  Auxiliary? get currentAuxiliary => _currentQuizzableTense?.auxiliary;
  bool get isDoubleAuxiliary => _currentQuizzableTense?.verb.isDoubleAuxiliary ?? false;

  // Randomize Quiz
  final _random = Random();
  bool get hasRandomizedValues {
    return _currentVerb != null && _currentQuizzableTense != null;
  }

  // Quiz Labels
  String? get currentTitle => _currentQuizzableTense?.currentTitle;
  String? get currentQuestion => _currentQuizzableTense?.question(_currentPronoun);
  String? get currentTranslation => _currentQuizzableTense?.translation(_currentPronoun);

  void _loadVerbPrefs() {
    debugPrint("QuizViewModel | _loadVerbPrefs()");
    _verbPrefs = prefs?.getStringList(SharedPreferenceKeys.quizzableVerbs)?.toSet() ?? {};
    debugPrint("QuizViewModel | Available Verb Prefs: $_verbPrefs");
    notifyListeners();
  }

  void _loadTensePrefs() {
    debugPrint("QuizViewModel | _loadTensePrefs()");
    _tensePrefs = prefs?.getStringList(SharedPreferenceKeys.quizzableTenses)?.toSet() ?? {};
    debugPrint("QuizViewModel | Available Tense Prefs: $_tensePrefs");
    notifyListeners();
  }

  void _findQuizzableVerb() {
    _loadVerbPrefs();

    debugPrint("QuizViewModel | _findQuizzableVerb() started");
    _quizzableVerbs.clear();

    for (final verb in _verbs) {
      if (!_verbPrefs.contains(verb.prefKey)) continue;
      _quizzableVerbs.add(verb);
    }

    debugPrint("QuizViewModel | QuizzableVerbs Count: ${_quizzableVerbs.length}");

    debugPrint("QuizViewModel | _findQuizzableVerb() ended");
  }

  void _findQuizzableTenses() {
    _loadTensePrefs();

    if (_currentVerb == null) {
      return debugPrint("QuizViewModel | No current Verb -> Cannot find QuizzableTenses");
    }

    debugPrint("QuizViewModel | _findQuizzableTenses() started");
    _quizzableTenses.clear();

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

    debugPrint("QuizViewModel | QuizzableTense Count: ${_quizzableTenses.length}");

    debugPrint("QuizViewModel | _findQuizzableTenses() ended");
  }

  updateVerbs(List<Verb> verbs) {
    Function eq = const ListEquality().equals;
    if(eq(_verbs, verbs)) return debugPrint("QuizViewModel | loaded verbs are still the same");
    debugPrint("QuizViewModel | updateVerbs()");
    _verbs = verbs;
    //notifyListeners();
    randomizeVerb();
  }

  randomizeVerb() {
    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("QuizViewModel | no verbs to randomize");
    }
    debugPrint("QuizViewModel | randomizeVerb() started");

    do{
      if(_currentVerb != null) {
        if (_currentSolution == null) {
          debugPrint(
              "QuizViewModel | Got a NULL Conjugation for Tense: ${_currentQuizzableTense?.tense.label} and Pronoun: ${_currentPronoun.italian}");
        }
        if(!_tensePrefs.contains(_currentTensePrefKey)){
          debugPrint("QuizViewModel | Tense Pref not found: $_currentTensePrefKey");
        }
        debugPrint("QuizViewModel | Re-Randomize verb");
      }

      // Find quizzable Verb
      _findQuizzableVerb();
      // TODO Create extensions
      if(_quizzableVerbs.isEmpty) _currentVerb = null;
      else _currentVerb = _quizzableVerbs[_random.nextInt(_quizzableVerbs.length)];

      // Find quizzable Tenses
      _findQuizzableTenses();
      if(!hasQuizzableTenses) {
        _currentQuizzableTense = null;
        notifyListeners();
        return debugPrint("QuizViewModel | No QuizzableTenses found");
      }
      _currentQuizzableTense = _quizzableTenses.elementAtOrNull(_random.nextInt(_quizzableTenses.length));

      _currentPronoun = Pronoun.values[_random.nextInt(Pronoun.values.length)];

      // TODO Check if QuizzableTense is equal to the previous
    } while(!_tensePrefs.contains(_currentTensePrefKey) || _currentSolution == null);

    debugPrint("QuizViewModel | Current Verb: ${_currentVerb?.infinitive}");
    debugPrint("QuizViewModel | Solution: (${_currentPronoun.italian}) $_currentSolution");

    notifyListeners();
    debugPrint("QuizViewModel | randomizeVerb() ended");
  }

  isAnswerCorrect(String answer) {
    debugPrint("QuizViewModel | isAnswerCorrect()");
    _currentAnswer = answer;
    final usingEssere = _currentQuizzableTense?.auxiliary.requiresGenderedParticiple ?? false;
    final usingParticiple = _currentQuizzableTense?.tense.usesPastParticiple ?? false;
    if (usingEssere && usingParticiple) {
      _currentAnswer = _currentPronoun.genderItalianConjugationIfPossible(answer);
    }
    debugPrint("QuizViewModel | Formatted Answer : $_currentAnswer");
    return _currentAnswer == _currentSolution;
  }

  printDifferences() {
    debugPrint("QuizViewModel | printDifferences() started");
    _currentAnswer?.printDifferences(_currentSolution ?? '');
    debugPrint("QuizViewModel | printDifferences() ended");
  }
}
