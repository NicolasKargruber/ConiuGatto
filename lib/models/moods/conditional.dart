import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../verb.dart';
import 'mood.dart';

class Conditional extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get name => "Condizionale";

  // Simple Tenses - Stored in JSON
  /// Presente
  final Conjugations present; // Presente

  // Compound Tenses - Generated dynamically
  /// Condizionale Passato
  Conjugations presentPerfectConditional(auxiliary) => verb.presentPerfectConditional(auxiliary);

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: MoodExtensions.parseConjugations(json['presente']),
    );
  }
}