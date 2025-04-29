import 'tense.dart';

/// => Condizionale Presente
final class PresentConditional extends Tense {
  static const String name = 'Presente';
  PresentConditional({required super.conjugations}) : super(label: name, extendedLabel: '$name - Condizionale');

  factory PresentConditional.fromJson(Map<String, dynamic> json) {
    return PresentConditional(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Condizionale Passato
final class PresentPerfectConditional extends Tense {
  static const String name = 'Passato';
  PresentPerfectConditional({required super.conjugations}) : super(label: name, extendedLabel: '$name - Condizionale', isCompound: true, usesPastParticiple: true);
}