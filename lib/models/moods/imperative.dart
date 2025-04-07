import 'indicative.dart';

class Imperative {
  final Conjugations positive; // Positivo Afirmativo
  // final Conjugation negative; // Negativo Afirmativo

  Imperative({
    required this.positive,
  });

  factory Imperative.fromJson(Map<String, dynamic> json) {
    return Imperative(
        positive: parseConjugations(json['positivo'])
    );
  }
}