import 'indicative.dart';

class Conditional {
  final Conjugations present; // Presente
  // final Conjugation passato; // Present Perfect

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: parseConjugations(json['presente']),
    );
  }
}