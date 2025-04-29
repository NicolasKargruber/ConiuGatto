import '../tenses/subjunctive_tenses.dart';
import '../../utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';

class Subjunctive extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static labels
  static const String name = "Congiuntivo";

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, imperfect, presentPerfectSubjunctive(auxiliary), pastPerfectSubjunctive(auxiliary) ];

  Tense Function(Auxiliary) getTense(SubjunctiveTense tense) =>
      switch(tense)
      {
        SubjunctiveTense.present => (_) => present,
        SubjunctiveTense.imperfect => (_) => imperfect,
        SubjunctiveTense.presentPerfect => presentPerfectSubjunctive,
        SubjunctiveTense.pastPerfect => pastPerfectSubjunctive
      };

  // Simple Tenses - Stored in JSON
  /// => Presente
  final PresentSubjunctive present; // Presente
  /// => Imperfetto
  final ImperfectSubjunctive imperfect; // Imperfetto

  // Compound Tenses - Generated dynamically
  /// => Congiuntivo Passato
  PresentPerfectSubjunctive presentPerfectSubjunctive(auxiliary) => verb.presentPerfectSubjunctive(auxiliary);

  /// => Congiuntivo Trapassato
  PastPerfectSubjunctive pastPerfectSubjunctive(auxiliary) => verb.pastPerfectSubjunctive(auxiliary);

  Subjunctive({
    required this.present,
    required this.imperfect,
  });

  factory Subjunctive.fromJson(Map<String, dynamic> json) {
    return Subjunctive(
      present: PresentSubjunctive.fromJson(json['presente']),
      imperfect: ImperfectSubjunctive.fromJson(json['imperfetto']),
    );
  }
}

typedef LabeledTense = ({String prefKey, String label});

enum SubjunctiveTense {
  present("Presente"),
  imperfect("Imperfetto"),
  presentPerfect("Passato"),
  pastPerfect("Trapassato");

  final String label;
  const SubjunctiveTense(this.label);

  String get prefKey => toString();
  static List<LabeledTense>  get valuesLabeled => values.map((e) => (prefKey: e.prefKey, label: e.label)).toList();
}