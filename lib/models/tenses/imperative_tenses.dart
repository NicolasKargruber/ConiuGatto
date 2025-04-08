import 'tense.dart';

/// => Imperativo Positivo
final class PositiveImperative extends Tense {
  PositiveImperative({required super.conjugations}) : super(label: 'Positivo');

  factory PositiveImperative.fromJson(Map<String, dynamic> json) {
    return PositiveImperative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Imperativo Negativo
final class NegativeImperative extends Tense {
  NegativeImperative({required super.conjugations}) : super(label: 'Negativo');
}