import '../verb.dart';
import 'mood.dart';

class Conditional extends Mood {
  // Parent Reference
  late final Verb verb;

  // Conjugations
  final Conjugations present; // Presente
  // final Conjugation passato; // Present Perfect

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: MoodExtensions.parseConjugations(json['presente']),
    );
  }
}