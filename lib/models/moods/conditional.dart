import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../tense.dart';
import '../verb.dart';
import 'mood.dart';

class Conditional extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get name => "Condizionale";

  // Simple Tenses - Stored in JSON
  /// Presente
  final Tense present; // Presente

  // Compound Tenses - Generated dynamically
  /// Condizionale Passato
  Tense presentPerfectConditional(auxiliary) => verb.presentPerfectConditional(auxiliary);

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: Tense.fromJson(json['presente'], name: 'Presente'),
    );
  }
}