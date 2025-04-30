import 'package:flutter/foundation.dart';

import '../utilities/extensions/string_extensions.dart';
import 'answer_result.dart';
import 'auxiliary.dart';
import 'pronoun.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class QuizItem {
  late final _logTag = (this).toString();

  final Verb verb;
  final Auxiliary auxiliary;
  final Tense tense;
  final Pronoun pronoun;

  String? _answer;
  String? get answer => _answer;

  int _triesLeft = 2;
  int get triesLeft => _triesLeft;

  AnswerResult? _answerResult;
  AnswerResult? get answerResult => _answerResult;

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

  // Helper Method
  void genderAnswer() {
    if(_answer case var answer?) {
      _answer = pronoun.genderItalianConjugationIfPossible(answer);
      debugPrint("$_logTag | Answer with gender: $_answer");
    }
  }

  void checkAnswer(String answer) {
    if(triesLeft > 0) {
      _triesLeft--;
      _answer = answer;

      // Correct
      if (answer == solution) {
        _answerResult = AnswerResult.correct;
        return debugPrint("$_logTag | Answer Correct: $answer");
      }

      // Missing Accents
      if (answer == solution?.removeDiacritics()) {
        _answerResult = AnswerResult.missingAccents;
        return debugPrint("$_logTag | Solution without Accents: ${solution?.removeDiacritics()}");
      }

      // 1 Letter Away
      if (answer.levenshteinDistance(solution ?? '') == 1) {
        _answerResult = AnswerResult.almostCorrect;
        return debugPrint("$_logTag | Answer 1 Letter Away: $answer");
      }

      // Force Gendered Participle
      if (pronoun.genderItalianConjugationIfPossible(answer, forceGender: true) == solution) {
        _answerResult = AnswerResult.almostCorrect;
        return debugPrint("$_logTag | Answer with forced gender: ${pronoun.genderItalianConjugationIfPossible(answer, forceGender: true)}");
      }
    }

    // Incorrect
    _answerResult = AnswerResult.incorrect;
    _triesLeft = 0;
  }

  // Labels
  String? get currentTitle => tense.extendedLabel;
  String get question => "${pronoun.italian} (${verb.italianInfinitive})";
  String get translation => "${pronoun.english} ${tense[pronoun]?.english}";
  String? get solutionExtended => "(${pronoun.italian}) $solution";

  // Quiz
  String? get solution => tense[pronoun]?.italian;
}