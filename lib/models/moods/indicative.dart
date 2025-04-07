import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../verb.dart';
import 'mood.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Simple Tenses - Stored in JSON
  /// Presente
  final Conjugations present;
  /// Imperfecto
  final Conjugations imperfect;
  /// Passato Remoto
  final Conjugations historicalPresentPerfect;
  /// Futuro Semplice
  final Conjugations future;

  // Compound Tenses - Generated dynamically
  /// Presente Progressivo
  Conjugations get presentContinuous => verb.presentContinuous;

  /// Passato Prossimo
  Conjugations presentPerfect(auxiliary) => verb.presentPerfect(auxiliary);

  /// Trapassato Prossimo
  Conjugations pastPerfect(auxiliary) => verb.pastPerfect(auxiliary);

  /// Trapassato Prossimo
  Conjugations historicalPastPerfect(auxiliary) => verb.historicalPastPerfect(auxiliary);

  /// Futuro Anteriore
  Conjugations futurePerfect(auxiliary) => verb.futurePerfect(auxiliary);

  // Futuro Prossimo
  // TODO: => Futuro GOING TO - futuro prossimo

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
