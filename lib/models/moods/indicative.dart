import 'package:coniugatto/models/auxiliary.dart';
import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../pronoun.dart';
import '../verb.dart';
import 'mood.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Simple Tenses - Stored in JSON
  final Conjugations present; // Presente
  // final Conjugation presente progresivo; // Present Continuous
  final Conjugations imperfect; // Imperfecto
  final Conjugations historicalPresentPerfect; // Passato Remoto
  // final Conjugation trapassato remoto; // Historical Past Perfect
  final Conjugations future; // Futuro Semplice
  // final Conjugation futuro prossimo; // Futuro GOING TO
  // final Conjugation futuro anteriore; // Futuro Perfect


  // Compound Tenses - Generated dynamically
  // Passato Prossimo
  Conjugations presentPerfect(Auxiliary auxiliary) {
    return verb.presentPerfect(auxiliary);
  }

  // Trapassato prossimo
  Conjugations pastPerfect(Auxiliary auxiliary) {
    return verb.pastPerfect(auxiliary);
  }

  // Compound tenses will be generated dynamically
  Indicative({
    required this.present,
    required this.imperfect,
    required this.historicalPresentPerfect,
    required this.future,
  });

  factory Indicative.fromJson(Map<String, dynamic> json) {
    return Indicative(
      present: MoodExtensions.parseConjugations(json['presente']),
      imperfect: MoodExtensions.parseConjugations(json['imperfetto']),
      historicalPresentPerfect: MoodExtensions.parseConjugations(json['passato_remoto']),
      future: MoodExtensions.parseConjugations(json['futuro_semplice']),
    );
  }
}
