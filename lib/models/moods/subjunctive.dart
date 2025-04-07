import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tense.dart';
import '../verb.dart';
import 'mood.dart';

class Subjunctive extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get name => "Congiuntivo";

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, imperfect, presentPerfectSubjunctive(auxiliary), pastPerfectSubjunctive(auxiliary) ];

  // Simple Tenses - Stored in JSON
  /// Presente
  final Tense present; // Presente
  /// Imperfetto
  final Tense imperfect; // Imperfetto

  // Compound Tenses - Generated dynamically
  /// Congiuntivo Passato
  Tense presentPerfectSubjunctive(auxiliary) => verb.presentPerfectSubjunctive(auxiliary);

  /// Congiuntivo Trapassato
  Tense pastPerfectSubjunctive(auxiliary) => verb.pastPerfectSubjunctive(auxiliary);

  Subjunctive({
    required this.present,
    required this.imperfect,
  });

  factory Subjunctive.fromJson(Map<String, dynamic> json) {
    return Subjunctive(
      present: Tense.fromJson(json['presente'], name: 'Presente'),
      imperfect: Tense.fromJson(json['imperfetto'], name: 'Imperfetto'),
    );
  }
}