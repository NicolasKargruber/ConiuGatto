import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../tense.dart';
import '../verb.dart';
import 'mood.dart';

class Imperative extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get name => "Imperativo";

  // Simple Tenses - Stored in JSON
  final Tense positive; // Positivo Afirmativo

  // Compound Tenses - Generated dynamically
  Tense get negative => verb.negativeImperative;

  Imperative({
    required this.positive,
  });

  factory Imperative.fromJson(Map<String, dynamic> json) {
    return Imperative(
        positive: Tense.fromJson(json['positivo'], name: 'Positivo')
    );
  }
}