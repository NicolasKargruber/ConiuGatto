enum AnswerResult {
  incorrect("❌ Wrong Answer!"),
  missingAccents("🎩 Almost, accents are missing ..."),
  almostCorrect("🧐 There is a typo somewhere ..."),
  correct("✅ Correct Answer!");
  final String message;

  bool get isCorrect => this == AnswerResult.correct;

  const AnswerResult(this.message);
}