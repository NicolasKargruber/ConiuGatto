import 'dart:math';

import 'package:collection/collection.dart';
import 'package:coniugatto/utilities/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import '../models/auxiliary.dart';
import '../models/moods/mood.dart';
import '../models/pronoun.dart';
import '../models/tense.dart';
import '../models/verb.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  // Update & Notify
  List<Verb> _verbs = [];

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("QuizViewModel | initialize()");
  }

  // Random Quiz
  Verb? currentVerb;
  Auxiliary? currentAuxiliary;
  Mood? currentMood;
  Tense? currentTense;
  List<Tense> currentTenses = [];
  Pronoun currentPronoun = Pronoun.firstSingular;
  String? currentSolution;
  String? currentAnswer;

  final _random = Random();

  bool get hasRandomizedValues {
    return currentVerb != null &&
        currentAuxiliary != null &&
        currentMood != null &&
        currentTense != null;
  }

  String get currentTitle => "${currentTense?.name} - ${currentMood?.name}";
  String get currentQuestion => "${currentPronoun.italian} (${currentVerb?.infinitive})";
  String get currentTranslation => "${currentPronoun.english} ${currentTense?[currentPronoun]?.english}";

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
      if(currentTense?[currentPronoun].italian == null){
        debugPrint("QuizViewModel | Got a NULL Conjugation for Tense: ${currentTense?.name} and Pronoun: ${currentPronoun.italian}");
        debugPrint("QuizViewModel | Re-Randomize verb");
      }
      currentVerb = _verbs[_random.nextInt(_verbs.length)];
      currentAuxiliary = currentVerb?.auxiliaries[_random.nextInt(currentVerb!.auxiliaries.length)];
      currentMood = currentVerb?.moods[_random.nextInt(currentVerb!.moods.length)];
      currentTenses = currentMood?.getTenses(currentAuxiliary ?? Auxiliary.avere) ?? [];
      currentTense = currentTenses[_random.nextInt(currentTenses.length)];
      currentPronoun = Pronoun.values[_random.nextInt(Pronoun.values.length)];
      currentSolution = currentTense?[currentPronoun].italian;
    } while(currentTense?[currentPronoun].italian == null);

    debugPrint("QuizViewModel | Current Verb: ${currentVerb?.infinitive}");
    debugPrint("QuizViewModel | Solution: (${currentPronoun.italian}) $currentSolution");

    notifyListeners();
    debugPrint("QuizViewModel | randomizeVerb() ended");
  }

  areAnswersEqual(String answer) {
    debugPrint("QuizViewModel | areAnswersEqual()");
    currentAnswer = answer;
    if ((currentAuxiliary?.requiresGenderedParticiple ?? false) && (currentTense?.usesPastParticiple ?? false)) {
      currentAnswer = currentPronoun.genderItalianConjugationIfPossible(answer);
    }
    debugPrint("QuizViewModel | Current Answer : $currentAnswer");
    return currentAnswer == currentSolution;
  }

  printDifferences() {
    debugPrint("QuizViewModel | printDifferences() started");
    currentAnswer?.printDifferences(currentTense?[currentPronoun]?.italian ?? '');
    debugPrint("QuizViewModel | printDifferences() ended");
  }
}
