import '../../enums/pronoun.dart';
import '../verb.dart';
import '../../enums/italian_tense.dart';

ConjugatedVerb? _conjugatedVerb(Map<String, dynamic>? json) {
  try {
     return (italian: json?['italian'], english: json?['english']);
  } catch (_) {
    return null;
  }
}

base class Tense {
  final ItalianTense type;
  final bool usesPastParticiple;
  final bool isCompound;
  final Conjugations conjugations;
  ItalianConjugations? generatedConjugations;

  Tense({required this.type, required this.conjugations, this.usesPastParticiple = false, this.isCompound = false});

  /// Used for Shared Preferences
  String get prefKey => runtimeType.toString();

  // Labels
  String get label => type.label;
  String get extendedLabel => type.extendedLabel;

  operator [](Pronoun? pronoun) => conjugations[pronoun];

  static Conjugations convertJsonToConjugations(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) => Conjugation(pronoun, _conjugatedVerb(json[pronoun.jsonKey]));
    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }

  // TODO Remove
  factory Tense.fromJson(Map<String, dynamic> json, {required ItalianTense type}) {
    return Tense(conjugations: convertJsonToConjugations(json), type: type);
  }
}