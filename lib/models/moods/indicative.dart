import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/indicative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'imperative.dart';
import 'mood.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static Labels
  static const String name = "Indicativo";
  static List<LabeledTense> get getLabeledTenses => [
    (PresentIndicative, label: PresentIndicative.name),
    (PresentContinuousIndicative, label: PresentContinuousIndicative.name),
    (ImperfectIndicative, label: ImperfectIndicative.name),
    (PresentPerfectIndicative, label: PresentPerfectIndicative.name),
    (PastPerfectIndicative, label: PastPerfectIndicative.name),
    (HistoricalPresentPerfectIndicative, label: HistoricalPresentPerfectIndicative.name),
    (HistoricalPastPerfectIndicative, label: HistoricalPastPerfectIndicative.name),
    (FutureIndicative, label: FutureIndicative.name),
    (FuturePerfectIndicative, label: FuturePerfectIndicative.name)
  ];

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, presentContinuous, imperfect, presentPerfect(auxiliary), pastPerfect(auxiliary), historicalPresentPerfect, historicalPastPerfect(auxiliary), future, futurePerfect(auxiliary)];

  // Simple Tenses - Stored in JSON
  /// => Presente
  final PresentIndicative present;
  /// => Imperfecto
  final ImperfectIndicative imperfect;
  /// => Passato Remoto
  final HistoricalPresentPerfectIndicative historicalPresentPerfect;
  /// => Futuro Semplice
  final FutureIndicative future;

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
