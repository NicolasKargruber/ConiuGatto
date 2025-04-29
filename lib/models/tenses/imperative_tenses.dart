import 'tense.dart';

/// => Imperativo Positivo
final class PositiveImperative extends Tense {
  static const String name = 'Positivo';
  PositiveImperative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Imperativo');

  factory PositiveImperative.fromJson(Map<String, dynamic> json) {
    return PositiveImperative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Imperativo Negativo
final class NegativeImperative extends Tense {
  static const String name = 'Negativo';
  NegativeImperative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Imperativo');
}