import 'italian_tense.dart';
import 'tense.dart';

/// => Imperativo Positivo
final class PositiveImperative extends Tense {
  static const String jsonKey = 'positivo';
  PositiveImperative({required super.conjugations}) : super(type: ItalianTense.positiveImperative);

  factory PositiveImperative.fromJson(Map<String, dynamic> json) {
    return PositiveImperative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Imperativo Negativo
final class NegativeImperative extends Tense {
  NegativeImperative({required super.conjugations}) : super(type: ItalianTense.negativeImperative);
}