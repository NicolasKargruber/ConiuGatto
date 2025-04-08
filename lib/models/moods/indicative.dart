import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/indicative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get label => "Indicativo";

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, presentContinuous, imperfect, presentPerfect(auxiliary), pastPerfect(auxiliary), historicalPresentPerfect, historicalPastPerfect(auxiliary), future, futurePerfect(auxiliary)];

  // Simple Tenses - Stored in JSON
  /// => Presente
  final Tense present;
  /// => Imperfecto
  final Tense imperfect;
  /// => Passato Remoto
  final Tense historicalPresentPerfect;
  /// => Futuro Semplice
  final Tense future;

  // Compound Tenses - Generated dynamically
  /// => Presente Progressivo
  PresentContinuousIndicative get presentContinuous => verb.presentContinuous;

  /// => Passato Prossimo
  PresentPerfectIndicative presentPerfect(auxiliary) => verb.presentPerfect(auxiliary);

  /// => Trapassato Prossimo
  PastPerfectIndicative pastPerfect(auxiliary) => verb.pastPerfect(auxiliary);

  /// => Trapassato Remoto
  HistoricalPastPerfectIndicative historicalPastPerfect(auxiliary) => verb.historicalPastPerfect(auxiliary);

  /// => Futuro Anteriore
  FuturePerfectIndicative futurePerfect(auxiliary) => verb.futurePerfect(auxiliary);

  // => Futuro Prossimo
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
      present: PresentIndicative.fromJson(json['presente']),
      imperfect: ImperfectIndicative.fromJson(json['imperfetto']),
      historicalPresentPerfect: HistoricalPresentPerfectIndicative.fromJson(json['passato_remoto']),
      future: FutureIndicative.fromJson(json['futuro_semplice']),
    );
  }
}
