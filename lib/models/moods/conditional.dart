import 'package:coniugatto/utilities/extensions/verb_extensions.dart';

import '../auxiliary.dart';
import '../tenses/conditional_tenses.dart';
import '../tenses/indicative_tenses.dart';
import '../tenses/tense.dart';
import '../verb.dart';
import 'mood.dart';

class Conditional extends Mood {
  // Parent Reference
  late final Verb verb;

  @override
  String get label => "Condizionale";

  @override
  List<Tense> getTenses(Auxiliary auxiliary) => [present, presentPerfectConditional(auxiliary)];

  // Simple Tenses - Stored in JSON
  /// Presente
  final PresentIndicative present; // Presente

  // Compound Tenses - Generated dynamically
  /// Condizionale Passato
  PresentPerfectConditional presentPerfectConditional(auxiliary) => verb.presentPerfectConditional(auxiliary);

  Conditional({
    required this.present
  });

  factory Conditional.fromJson(Map<String, dynamic> json) {
    return Conditional(
      present: PresentIndicative.fromJson(json['presente']),
    );
  }
}