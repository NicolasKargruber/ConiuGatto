import 'package:flutter/foundation.dart';

import '../../utilities/extensions/string_extensions.dart';
import 'answer_result.dart';
import '../../data/enums/auxiliary.dart';
import '../../data/enums/pronoun.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class QuizItem {
  final _logTag = (QuizItem).toString();

  final Verb verb;
  final Auxiliary auxiliary;
  final Tense tense;
  final Pronoun pronoun;

  String? _answer;
  String? get answer => _answer;

  int _triesLeft = 2;
  int get triesLeft => _triesLeft;

  QuizItem({
    required this.verb,
    required this.auxiliary,
    required this.tense,
    required this.pronoun,
  });

  // Helper
  bool get isDoubleAuxiliary => verb.isDoubleAuxiliary;
  bool get usesPastParticiple => tense.usesPastParticiple;
  bool get usesEssere => auxiliary.requiresGenderedParticiple;
  bool get hasConjugations {
    return tense.conjugations.values.any((conjugatedVerb) => conjugatedVerb != null);
  }
  bool get hasTriesLeft => _triesLeft > 0;
  bool get isCorrect => _answer == solution;

  // Helper Method
  void genderAnswer() {
    if(_answer case var answer?) {
      _answer = pronoun.genderItalianConjugationIfPossible(answer);
      debugPrint("$_logTag | Answer with gender: $_answer");
    }
  }

  AnswerResult checkAnswer(String answer) {
    if(triesLeft > 0) {
      _triesLeft--;
      _answer = answer;

      // Correct
      if (answer == solution) {
        debugPrint("$_logTag | Answer Correct: $answer");
        return AnswerResult.correct;
      }

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
        debugPrint("$_logTag | Answer with forced gender: ${pronoun.genderItalianConjugationIfPossible(answer, forceGender: true)}");
        return AnswerResult.almostCorrect;
      }
    }

    // Incorrect
    _triesLeft = 0;
    debugPrint("$_logTag | Incorrect, no tries left.");
    return AnswerResult.incorrect;
  }

  // Labels
  String? get currentTitle => tense.extendedLabel;
  String get question => "${pronoun.italian} (${verb.italianInfinitive})";
  String? get translation => tense[pronoun]?.englishWithPronoun;
  String? get solutionExtended => "(${pronoun.italian}) $solution";

  // Quiz
  String? get solution => tense[pronoun]?.italian;
}