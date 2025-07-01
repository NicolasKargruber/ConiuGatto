enum AnswerResult {
  incorrect,
  blank,
  wrongPronoun,
  missingAccents,
  almostCorrect,
  correct;

  bool get isCorrect => this == AnswerResult.correct;
}