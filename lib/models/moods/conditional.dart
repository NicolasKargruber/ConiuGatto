import '../../utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/conditional_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';
import 'subjunctive.dart';

class Conditional extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static Labels
  static const String name = "Condizionale";

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, presentPerfectConditional(auxiliary)];

  Tense Function(Auxiliary) getTense(ConditionalTense tense) =>
      switch(tense)
      {
        ConditionalTense.present => (_) => present,
        ConditionalTense.presentPerfect => presentPerfectConditional,
      };

  // Simple Tenses - Stored in JSON
  /// Presente
  final PresentConditional present; // Presente

  // Compound Tenses - Generated dynamically
  /// Condizionale Passato
  PresentPerfectConditional presentPerfectConditional(auxiliary) => verb.presentPerfectConditional(auxiliary);

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: PresentConditional.fromJson(json['presente']),
    );
  }
}

enum ConditionalTense { present("Presente"), presentPerfect("Passato");

  final String label;
  const ConditionalTense(this.label);

  String get prefKey => toString();
  static List<LabeledTense>  get valuesLabeled => values.map((e) => (prefKey: e.prefKey, label: e.label)).toList();
}