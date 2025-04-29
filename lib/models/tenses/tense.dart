import '../pronoun.dart';
import '../verb.dart';

ConjugatedVerb? _conjugatedVerb(Map<String, dynamic>? json) {
  try {
     return (italian: json?['italian'], english: json?['english']);
  } catch (_) {
    return null;
  }
}

base class Tense {
  final String label;
  final String extendedLabel;
  final bool usesPastParticiple;
  final bool isCompound;
  final Conjugations conjugations;
  ItalianConjugations? generatedConjugations;

  /// Used for Shared Preferences
  String get prefKey => runtimeType.toString();

  operator [](Pronoun? pronoun) => conjugations[pronoun];

  static Conjugations convertJsonToConjugations(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) => Conjugation(pronoun, _conjugatedVerb(json[pronoun.jsonKey]));
    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }

  Tense({required this.label, required this.extendedLabel, required this.conjugations, this.usesPastParticiple = false, this.isCompound = false});

  factory Tense.fromJson(Map<String, dynamic> json, {required String label, required  String extendedLabel}) {
    return Tense(label: label, extendedLabel: extendedLabel, conjugations: convertJsonToConjugations(json));
  }
}