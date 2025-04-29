import '../../utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/indicative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';
import 'subjunctive.dart';

class Indicative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static Labels
  static const String name = "Indicativo";

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [
    present,
    presentContinuous,
    imperfect,
    presentPerfect(auxiliary),
    pastPerfect(auxiliary),
    historicalPresentPerfect,
    historicalPastPerfect(auxiliary),
    future,
    futurePerfect(auxiliary)
  ];

  @override
  final String label = name;

  //@override
  Tense Function(Auxiliary) getTense(IndicativeTense tense) =>
  switch(tense)
      {
        IndicativeTense.present => (_) => present,
        IndicativeTense.presentContinuous => (_) => presentContinuous,
        IndicativeTense.imperfect => (_) => imperfect,
        IndicativeTense.presentPerfect => presentPerfect,
        IndicativeTense.pastPerfect => pastPerfect,
        IndicativeTense.historicalPresentPerfect => (_) => historicalPresentPerfect,
        IndicativeTense.historicalPastPerfect => historicalPastPerfect,
        IndicativeTense.future => (_) => future,
        IndicativeTense.futurePerfect => futurePerfect,
      };

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

enum IndicativeTense {
  present("Presente"),
  presentContinuous("Presente Progressivo"),
  imperfect("Imperfetto"),
  presentPerfect("Passato Prossimo"),
  pastPerfect("Trapassato Prossimo"),
  historicalPresentPerfect("Passato Remoto"),
  historicalPastPerfect("Trapassato Remoto"),
  future("Futuro"),
  futurePerfect("Futuro Anteriore");

  final String label;
  const IndicativeTense(this.label);

  String get prefKey => toString();
  static List<LabeledTense> get valuesLabeled => values.map((e) => (prefKey: e.prefKey, label: e.label)).toList();
}
