import 'package:flutter/material.dart';

import '../../utilities/extensions/build_context_extensions.dart';
import '../models/answer_result.dart';

extension AnswerResultExtensions on AnswerResult {
  String getMessage(BuildContext context) => switch(this) {
    AnswerResult.incorrect => context.localization.incorrectAnswer,
    AnswerResult.blank => context.localization.blankAnswer,
    AnswerResult.wrongPronoun => context.localization.wrongPronounInAnswer,
    AnswerResult.removePronoun => context.localization.pronounNotAllowed,
    AnswerResult.missingAccents => context.localization.missingAccentsInAnswer,
    AnswerResult.almostCorrect => context.localization.almostCorrectAnswer,
    AnswerResult.correct => context.localization.correctAnswer
  };
}