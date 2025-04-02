import '../verb.dart';
import 'mood.dart';

class Imperative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Conjugations
  final Conjugations positive; // Positivo Afirmativo
  // final Conjugation negative; // Negativo Afirmativo

  Imperative({
    required this.positive,
  });

  factory Imperative.fromJson(Map<String, dynamic> json) {
    return Imperative(
        positive: MoodExtensions.parseConjugations(json['positivo'])
    );
  }
}