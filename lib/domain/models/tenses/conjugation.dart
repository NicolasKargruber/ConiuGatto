import 'dart:math';

import 'package:flutter/material.dart';

import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';
import '../../../data/utils/pronoun_extensions.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class Conjugation {
  final Pronoun pronoun;
  final String italianRegularPart;
  final String italianIrregularPart;
  final String english;
  final String german;
  // TODO add german translation

  Conjugation({
    required this.pronoun,
    required this.italianRegularPart,
    required this.italianIrregularPart,
    required this.english,
    required this.german,
  });

  factory Conjugation.from({
    required Pronoun pronoun,
    required TranslatedConjugation translatedConjugation,
    required String? generated,
  }){
    final original = translatedConjugation.italian;
    final english = translatedConjugation.english;
    final german = translatedConjugation.german;
    generated ??= original;

    // Find the longest common prefix (case-insensitive)
    final maxLength = min(original.length, generated.length);

    // Find the matching prefix (regular part)
    int i = 0;
    while (i < maxLength && original[i] == generated[i]) { i++; }

    final regularPart = original.substring(0, i);
    final irregularPart = original.substring(i);

    return Conjugation(
      pronoun: pronoun,
      italianRegularPart: regularPart,
      italianIrregularPart: irregularPart,
      english: english,
      german: german,
    );
  }

  // Getters - Helpers
  String get italian => italianRegularPart + italianIrregularPart;

  String getTranslationWithPronoun(BuildContext context, {bool useImperativePronoun = false}) {
    switch (context.localization.localeName) {
      case 'en':
        if (useImperativePronoun) {
          if (pronoun != Pronoun.secondPlural) {
            return "(${pronoun.english}) $english";
          }
        }
        return "${pronoun.english} $english";
      case 'de':
        if (useImperativePronoun) return german;
        return "${pronoun.german} $german";
      default:
        return "${pronoun.english} $english";
    }
  }
}