import '../../enums/italian_tense.dart';
import 'tense.dart';

/// => Condizionale Presente
final class PresentConditional extends Tense {
  static const String jsonKey = 'presente';
  PresentConditional({required super.conjugations}) : super(type: ItalianTense.presentConditional);

  factory PresentConditional.fromJson(Map<String, dynamic> json) {
    return PresentConditional(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Condizionale Passato
final class PresentPerfectConditional extends Tense {
  PresentPerfectConditional({required super.conjugations}) : super(type: ItalianTense.presentPerfectConditional, isCompound: true, usesPastParticiple: true);
}