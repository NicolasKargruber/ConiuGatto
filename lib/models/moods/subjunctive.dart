import '../verb.dart';
import 'indicative.dart';
import 'mood.dart';

class Subjunctive extends Mood {
  // Parent Reference
  late final Verb verb;

  // Conjugations
  final Conjugations present; // Presente
  final Conjugations imperfect; // Imperfetto
  // final Conjugation passato; // Present Perfect
  // final Conjugation trapassato; // Past Perfect

  Subjunctive({
    required this.present,
    required this.imperfect,
  });

  factory Subjunctive.fromJson(Map<String, dynamic> json) {
    return Subjunctive(
      present: MoodExtensions.parseConjugations(json['presente']),
      imperfect: MoodExtensions.parseConjugations(json['imperfetto']),
    );
  }
}