import 'dart:math';

import '../../enums/italian_tense.dart';
import '../../enums/pronoun.dart';

// typedefs - Conjugations
typedef ConjugatedVerb = ({String italian, String english});
typedef Conjugations = Map<Pronoun, ConjugatedVerb?>;
typedef Conjugation = MapEntry<Pronoun, ConjugatedVerb?>;
conjugatedVerbFrom(dynamic json) => (italian: json['italian'], english: json['english']);
conjugatedVerbOrNullFrom(Map<String, dynamic>? json) => json != null ? conjugatedVerbFrom(json) : null;

// typedefs - Generated Conjugations
typedef GeneratedConjugations = Map<Pronoun, String?>;

// typedefs - Regular & Irregular Parts
typedef ItalianConjugationParts = ({String regularPart, String irregularPart});
typedef ItalianConjugationsParted = Map<Pronoun, ItalianConjugationParts?>;

base class Tense {
  final ItalianTense type;
  final bool usesPastParticiple;
  final bool isCompound;
  final Conjugations conjugations;
  GeneratedConjugations? generatedConjugations;
  ItalianConjugationsParted? italianConjugationsParted;

  Tense({required this.type, required this.conjugations, this.usesPastParticiple = false, this.isCompound = false});

  /// Used for Shared Preferences
  String get prefKey => runtimeType.toString();

  // Labels
  String get label => type.label;
  String get extendedLabel => type.extendedLabel;

  operator [](Pronoun? pronoun) => conjugations[pronoun];

  static Conjugations convertJsonToConjugations(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) => Conjugation(pronoun, conjugatedVerbOrNullFrom(json[pronoun.jsonKey]));
    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }

  // TODO Use show when conjugation is shorter than generation
  setItalianConjugationsParted() {
    // Null Safety
    if (generatedConjugations == null) return;
    italianConjugationsParted = generatedConjugations!.map<Pronoun, ItalianConjugationParts?>((pronoun, generated) {
      final original = conjugations[pronoun]?.italian;
      if (original == null || generated == null) return MapEntry(pronoun, null);

      // Find the longest common prefix (case-insensitive)
      final maxLength = min(original.length, generated.length);

      // Find the matching prefix (regular part)
      int i = 0;
      while (i < maxLength && original[i] == generated[i]) { i++; }

      final regularPart = original.substring(0, i);
      final irregularPart = original.substring(i);

      return MapEntry(pronoun, (regularPart: regularPart, irregularPart: irregularPart));
    });
  }
}