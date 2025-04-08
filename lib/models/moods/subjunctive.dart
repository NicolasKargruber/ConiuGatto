import 'package:coniugatto/models/tenses/subjunctive_tenses.dart';
import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';

class Subjunctive extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static labels
  static const String name = "Congiuntivo";
  static List<LabeledTense> get getLabeledTenses => [
    (PresentSubjunctive, label: PresentSubjunctive.name),
    (ImperfectSubjunctive, label: ImperfectSubjunctive.name),
    (PresentPerfectSubjunctive, label: PresentPerfectSubjunctive.name),
    (PastPerfectSubjunctive, label: PastPerfectSubjunctive.name)
  ];

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, imperfect, presentPerfectSubjunctive(auxiliary), pastPerfectSubjunctive(auxiliary) ];

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