import '../enums/pronoun.dart';

// typedefs - Conjugations
typedef ConjugatedVerb = ({String italian, String english});
typedef Conjugations = Map<Pronoun, ConjugatedVerb?>;
typedef Conjugation = MapEntry<Pronoun, ConjugatedVerb?>;
conjugatedVerbFrom(dynamic json) => (italian: json['italian'], english: json['english']);
conjugatedVerbOrNullFrom(Map<String, dynamic>? json) => json != null ? conjugatedVerbFrom(json) : null;

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