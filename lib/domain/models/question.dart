import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../data/utils/pronoun_extensions.dart';
import '../../utilities/extensions/string_extensions.dart';
import 'answer_result.dart';
import '../../data/enums/italian_auxiliary.dart';
import '../../data/enums/pronoun.dart';
import 'enums/mood.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class Question {
  static final _logTag = (Question).toString();

  final Verb verb;
  final ItalianAuxiliary auxiliary;
  final Tense tense;
  final Pronoun pronoun;

  String? _answer;

  String? get answer => _answer;

  int _triesLeft = 2;

  int get triesLeft => _triesLeft;

  Question({required this.verb, required this.auxiliary, required this.tense, required this.pronoun});

  // Helper
  bool get isDoubleAuxiliary => verb.isDoubleAuxiliary;

  bool get usesPastParticiple => tense.usesPastParticiple;

  bool get usesEssere => auxiliary.requiresGenderedParticiple;

  bool get hasConjugations {
    return tense.conjugations.values.any((conjugatedVerb) => conjugatedVerb != null);
  }

  bool get hasTriesLeft => _triesLeft > 0;

  // TODO: Check if solution or solutionWithPronoun
  bool get isCorrect => _answer == solution;

  // Helper Method
  void genderAnswer() {
    if (_answer case var answer?) {
      _answer = pronoun.genderItalianConjugationIfPossible(answer);
      debugPrint("$_logTag | Answer with gender: $_answer");
    }
  }

  AnswerResult checkAnswer(String answer) {
    if (triesLeft > 0) {
      _triesLeft--;

      if(answer.isEmpty) return AnswerResult.blank;

      String pronounPrefix = "";
      bool usesWrongPronoun = false;

      // Add Gender to Participle if necessary
      if (usesEssere && usesPastParticiple) {
        // Check if lui/lei pronoun + ...o/a is correctly gendered
        if (pronoun == Pronoun.thirdSingular) {
          if (answer.startsWith("lui ")) {
            pronounPrefix = "lui ";
            if(answer.endsWith("a")) usesWrongPronoun = true;
          }
          else if (answer.startsWith("lei ")) {
            pronounPrefix = "lei ";
            if(answer.endsWith("o")) usesWrongPronoun = true;
          }
        }

        answer = pronoun.genderItalianConjugationIfPossible(answer);
        debugPrint("$_logTag | Gendered Answer : $answer");
      }

      // Check for removable Pronouns
      if(pronounPrefix.isEmpty) {
        for (final p in Pronoun.values) {
          if (answer.startsWith("${p.italian} ")) {
            pronounPrefix = "${p.italian} ";
          if (pronounPrefix != "${pronoun.italian} ") usesWrongPronoun = true;
          }
        }
        if (answer.startsWith("lui ")) {
          pronounPrefix = "lui ";
          if(pronoun != Pronoun.thirdSingular) usesWrongPronoun = true;
        }
        else if (answer.startsWith("lei ")) {
          pronounPrefix = "lei ";
        if(pronoun != Pronoun.thirdSingular) usesWrongPronoun = true;
        }
      }

      _answer = answer;
      debugPrint("$_logTag | Answer: $_answer");

      // Remove pronoun prefix
      if(pronounPrefix.isNotEmpty) {
        answer = answer.replaceFirst(pronounPrefix, "");
        debugPrint("$_logTag | Without pronoun prefix: $answer");
        // TODO: Save answer with (any) pronoun prefix -> add solutionWithPronoun
        if(!usesWrongPronoun) _answer = answer;
      }

      if (answer == solution) {
        // Wrong Pronoun
        if (usesWrongPronoun) return AnswerResult.wrongPronoun;

        // Correct
        debugPrint("$_logTag | Answer is correct: $answer");
        return AnswerResult.correct;
      } else if (!usesWrongPronoun) {
        // Missing Accents
        if (answer == solution?.removeDiacritics()) {
          debugPrint("$_logTag | Solution without Accents: ${solution?.removeDiacritics()}");
          return AnswerResult.missingAccents;
        }

        // 1 Letter Away
        if (answer.levenshteinDistance(solution ?? '') == 1) {
          debugPrint("$_logTag | Answer 1 Letter Away: $answer");
          return AnswerResult.almostCorrect;
        }

        // Force Gendered Participle
        if (pronoun.genderItalianConjugationIfPossible(answer, forceGender: true) == solution) {
          debugPrint(
            "$_logTag | Answer with forced gender: ${pronoun.genderItalianConjugationIfPossible(answer, forceGender: true)}",
          );
          return AnswerResult.almostCorrect;
        }
      }
    }

    // Incorrect
    _triesLeft = 0;
    debugPrint("$_logTag | Incorrect, no tries left.");
    return AnswerResult.incorrect;
  }

  // Labels
  String? get currentTitle => tense.extendedLabel;

  String get question {
    if(tense.isImperative) return "${pronoun.italianImperative} (${verb.italianInfinitive})";
    return "${pronoun.italian} (${verb.italianInfinitive})";
  }

  String? getTranslation(BuildContext context) => tense[pronoun]?.getTranslationWithPronoun(context, useImperativePronoun: tense.isImperative);

  String? get solutionExtended => "(${pronoun.italian}) $solution";

  // Quiz
  String? get solution => tense[pronoun]?.italian;
  // TODO: Add solutionWithPronoun
}
