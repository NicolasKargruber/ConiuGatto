import 'indicative.dart';

class Subjunctive {
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
      present: parseConjugations(json['presente']),
      imperfect: parseConjugations(json['imperfetto']),
    );
  }
}