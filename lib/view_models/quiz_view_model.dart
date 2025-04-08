import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pronoun.dart';
import '../models/quizzable_tense.dart';
import '../models/verb.dart';
import '../utilities/extensions/string_extensions.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  // Update & Notify
  List<Verb> _verbs = [];

  // Shared Preferences
  late SharedPreferences prefs;
  Set<String> _tensePrefs = {};

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("QuizViewModel | initialize()");
    prefs = await SharedPreferences.getInstance();
    _tensePrefs = prefs.getStringList('tenseLabels')?.toSet() ?? {};
    debugPrint("QuizViewModel | Available Prefs: $_tensePrefs");
    randomizeVerb();
  }

  // Quiz Values
  final List<QuizzableTense> _quizzableTenses = [];
  QuizzableTense? _currentQuizzableTense;
  Verb? currentVerb;
  Pronoun currentPronoun = Pronoun.firstSingular;
  String? get currentSolution => _currentQuizzableTense?.solution(currentPronoun);
  String? currentAnswer;
  String? get currentPref => _currentQuizzableTense?.currentPref;
  bool get hasQuizzableTenses => _quizzableTenses.isNotEmpty;

  // Randomize Quiz
  final _random = Random();
  bool get hasRandomizedValues {
    return currentVerb != null && _currentQuizzableTense != null;
  }

  // Quiz Labels
  String? get currentTitle => _currentQuizzableTense?.currentTitle;
  String? get currentQuestion => _currentQuizzableTense?.question(currentPronoun);
  String? get currentTranslation => _currentQuizzableTense?.translation(currentPronoun);

  void _findQuizzableTenses() {
    if (currentVerb == null) {
      return debugPrint("QuizViewModel | No current Verb -> Cannot find QuizzableTenses");
    }

    debugPrint("QuizViewModel | _findQuizzableTenses() started");
    _quizzableTenses.clear();

    for (final auxiliary in currentVerb!.auxiliaries) {
      for (final mood in currentVerb!.moods) {
        final tenses = mood.getTenses(auxiliary);
        for (final tense in tenses) {
          final prefKey = "${mood.label}-${tense.label}";
          if (!_tensePrefs.contains(prefKey)) continue;
          final quizzableTense = QuizzableTense(verb: currentVerb!, auxiliary: auxiliary, mood: mood, tense: tense);
          if(quizzableTense.hasConjugatedVerbs) _quizzableTenses.add(quizzableTense);
        }
      }
    }

    debugPrint("QuizViewModel | Available Quiz Items Count: ${_quizzableTenses.length}");

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
    if (_verbs.isEmpty) return debugPrint("QuizViewModel | no verbs to randomize");
    debugPrint("QuizViewModel | randomizeVerb() started");

    do{
      if(currentVerb != null) {
        if (currentSolution == null) {
          debugPrint(
              "QuizViewModel | Got a NULL Conjugation for Tense: ${_currentQuizzableTense?.tense.label} and Pronoun: ${currentPronoun.italian}");
        }
        if(!_tensePrefs.contains(currentPref)){
          debugPrint("QuizViewModel | Tense Pref not found: $currentPref");
        }
        debugPrint("QuizViewModel | Re-Randomize verb");
      }
      currentVerb = _verbs[_random.nextInt(_verbs.length)];

      // Find quizzable Tenses
      _findQuizzableTenses();
      _currentQuizzableTense = _quizzableTenses[_random.nextInt(_quizzableTenses.length)];

      currentPronoun = Pronoun.values[_random.nextInt(Pronoun.values.length)];
    } while(!_tensePrefs.contains(currentPref) || currentSolution == null);

    debugPrint("QuizViewModel | Current Verb: ${currentVerb?.infinitive}");
    debugPrint("QuizViewModel | Solution: (${currentPronoun.italian}) $currentSolution");

    notifyListeners();
    debugPrint("QuizViewModel | randomizeVerb() ended");
  }

  areAnswersEqual(String answer) {
    debugPrint("QuizViewModel | areAnswersEqual()");
    currentAnswer = answer;
    final usingEssere = _currentQuizzableTense?.auxiliary.requiresGenderedParticiple ?? false;
    final usingParticiple = _currentQuizzableTense?.tense.usesPastParticiple ?? false;
    if (usingEssere && usingParticiple) {
      currentAnswer = currentPronoun.genderItalianConjugationIfPossible(answer);
    }
    debugPrint("QuizViewModel | Current Answer : $currentAnswer");
    return currentAnswer == currentSolution;
  }

  printDifferences() {
    debugPrint("QuizViewModel | printDifferences() started");
    currentAnswer?.printDifferences(currentSolution ?? '');
    debugPrint("QuizViewModel | printDifferences() ended");
  }
}
