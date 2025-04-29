import '../../utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/imperative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';
import 'subjunctive.dart';

class Imperative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static Labels
  static const String name = "Imperativo";

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [positive, negative];

  Tense Function(Auxiliary) getTense(ImperativeTense tense) =>
      switch(tense)
      {
        ImperativeTense.positive => (_) => positive,
        ImperativeTense.negative => (_) => negative
      };

  // Simple Tenses - Stored in JSON
  /// => Imperativo Positivo
  final PositiveImperative positive; // Positivo Afirmativo

  // Compound Tenses - Generated dynamically
  /// => Imperativo Negativo
  NegativeImperative get negative => verb.negativeImperative;

  Imperative({
    required this.positive,
  });

  factory Imperative.fromJson(Map<String, dynamic> json) {
    return Imperative(
        positive: PositiveImperative.fromJson(json['positivo'])
    );
  }
}

enum ImperativeTense { positive("Positivo"), negative("Negativo");

  final String label;
  const ImperativeTense(this.label);

  String get prefKey => toString();
  static List<LabeledTense>  get valuesLabeled => values.map((e) => (prefKey: e.prefKey, label: e.label)).toList();
}