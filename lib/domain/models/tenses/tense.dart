import '../../../data/enums/italian_tense.dart';
import '../../../data/enums/pronoun.dart';
import '../enums/mood.dart';
import 'conjugation.dart';

// typedefs - Generated Conjugations
typedef GeneratedConjugations = Map<Pronoun, String?>;

class Tense {
  final ItalianTense type;
  final bool usesPastParticiple;
  final bool isCompound;
  final Conjugation? firstConjugationSingular;
  final Conjugation? secondConjugationSingular;
  final Conjugation? thirdConjugationSingular;
  final Conjugation? firstConjugationPlural;
  final Conjugation? secondConjugationPlural;
  final Conjugation? thirdConjugationPlural;

  Tense({
    required this.type,
    required this.firstConjugationSingular,
    required this.secondConjugationSingular,
    required this.thirdConjugationSingular,
    required this.firstConjugationPlural,
    required this.secondConjugationPlural,
    required this.thirdConjugationPlural,
    this.usesPastParticiple = false,
    this.isCompound = false
  });

  /// Used for Shared Preferences
  String get prefKey => runtimeType.toString();

  // Getters - Labels
  String get label => type.label;
  String get extendedLabel => type.extendedLabel;
  Map<Pronoun, Conjugation?> get conjugations =>
    {
      Pronoun.firstSingular: firstConjugationSingular,
      Pronoun.secondSingular: secondConjugationSingular,
      Pronoun.thirdSingular: thirdConjugationSingular,
      Pronoun.firstPlural: firstConjugationPlural,
      Pronoun.secondPlural: secondConjugationPlural,
      Pronoun.thirdPlural: thirdConjugationPlural,
    };

  // Helpers
  bool get hasConjugations => conjugations.values.any((conjugatedVerb) => conjugatedVerb != null);
  bool get isImperative => type.mood == Mood.imperative;

  Conjugation? operator [](Pronoun pronoun) =>
      switch (pronoun) {
        Pronoun.firstSingular => firstConjugationSingular,
        Pronoun.secondSingular => secondConjugationSingular,
        Pronoun.thirdSingular => thirdConjugationSingular,
        Pronoun.firstPlural => firstConjugationPlural,
        Pronoun.secondPlural => secondConjugationPlural,
        Pronoun.thirdPlural => thirdConjugationPlural,
      };
}