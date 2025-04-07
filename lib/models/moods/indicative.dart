import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tense.dart';
import '../verb.dart';
import 'mood.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get name => "Indicativo";

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, presentContinuous, imperfect, presentPerfect(auxiliary), pastPerfect(auxiliary), historicalPresentPerfect, historicalPastPerfect(auxiliary), future, futurePerfect(auxiliary)];

  // Simple Tenses - Stored in JSON
  /// Presente
  final Tense present;
  /// Imperfecto
  final Tense imperfect;
  /// Passato Remoto
  final Tense historicalPresentPerfect;
  /// Futuro Semplice
  final Tense future;

  // Compound Tenses - Generated dynamically
  /// Presente Progressivo
  Tense get presentContinuous => verb.presentContinuous;

  /// Passato Prossimo
  Tense presentPerfect(auxiliary) => verb.presentPerfect(auxiliary);

  /// Trapassato Prossimo
  Tense pastPerfect(auxiliary) => verb.pastPerfect(auxiliary);

  /// Trapassato Prossimo
  Tense historicalPastPerfect(auxiliary) => verb.historicalPastPerfect(auxiliary);

  /// Futuro Anteriore
  Tense futurePerfect(auxiliary) => verb.futurePerfect(auxiliary);

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
      present: Tense.fromJson(json['presente'], name: 'Presente'),
      imperfect: Tense.fromJson(json['imperfetto'], name: 'Imperfetto'),
      historicalPresentPerfect: Tense.fromJson(json['passato_remoto'], name: 'Passato Remoto'),
      future: Tense.fromJson(json['futuro_semplice'], name: 'Futuro Semplice'),
    );
  }
}
