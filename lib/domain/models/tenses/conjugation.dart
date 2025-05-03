import 'dart:math';

import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';

class Conjugation {
  final Pronoun pronoun;
  final String italianRegularPart;
  final String italianIrregularPart;
  final String english;
  // TODO add german translation

  Conjugation({
    required this.pronoun,
    required this.italianRegularPart,
    required this.italianIrregularPart,
    required this.english,
  });

  factory Conjugation.from({
    required Pronoun pronoun,
    required TranslatedConjugation conjugatedVerb,
    required String? generated,
  }){
    final original = conjugatedVerb.italian;
    final english = conjugatedVerb.english;
    generated ??= original;

    // Find the longest common prefix (case-insensitive)
    final maxLength = min(original.length, generated.length);

    // Find the matching prefix (regular part)
    int i = 0;
    while (i < maxLength && original[i] == generated[i]) { i++; }

    final regularPart = original.substring(0, i);
    final irregularPart = original.substring(i);

    return Conjugation(pronoun: pronoun, italianRegularPart: regularPart, italianIrregularPart: irregularPart, english: english);
  }

  // Getters - Helpers
  String get italian => italianRegularPart + italianIrregularPart;
  String get englishWithPronoun => "${pronoun.english} $english";
}