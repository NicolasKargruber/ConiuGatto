import '../enums/pronoun.dart';
import 'verb_dto.dart';

// typedefs - Conjugations
typedef Conjugation = MapEntry<Pronoun, TranslatedConjugation?>;
conjugatedVerbOrNullFrom(Map<String, dynamic>? json) => json != null ? translatedConjugationFrom(json) : null;

final _logTag = (TenseDTO).toString();

base class TenseDTO {
  final Conjugations conjugations;

  TenseDTO._({required this.conjugations});

  operator [](Pronoun? pronoun) => conjugations[pronoun];

  static Conjugations _conjugationsFrom(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) => Conjugation(pronoun, conjugatedVerbOrNullFrom(json[pronoun.jsonKey]));
    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }

  factory TenseDTO.fromJson(Map<String, dynamic> json) {
    return TenseDTO._(conjugations: _conjugationsFrom(json));
  }
}