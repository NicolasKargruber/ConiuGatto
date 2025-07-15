enum AnswerResult {
  incorrect,
  blank,
  wrongPronoun,
  removePronoun,
  missingAccents,
  almostCorrect,
  correct;

  bool get isCorrect => this == AnswerResult.correct;
}