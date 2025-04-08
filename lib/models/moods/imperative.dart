import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/imperative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';

class Imperative extends Mood {
  // Parent Reference
  late final Verb verb;

  // Static Labels
  static const String name = "Imperativo";
  static List<LabeledTense> get getLabeledTenses => [
    (PositiveImperative, label: PositiveImperative.name),
    (NegativeImperative, label: NegativeImperative.name)
  ];

  @override
  final String label = name;

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [positive, negative];

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