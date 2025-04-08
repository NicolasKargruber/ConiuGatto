import 'tense.dart';

/// => Condizionale Presente
final class PresentConditional extends Tense {
  PresentConditional({required super.conjugations}) : super(label: 'Presente');

  factory PresentConditional.fromJson(Map<String, dynamic> json) {
    return PresentConditional(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Condizionale Passato
final class PresentPerfectConditional extends Tense {
  PresentPerfectConditional({required super.conjugations}) : super(label: 'Passato', isCompound: true, usesPastParticiple: true);
}