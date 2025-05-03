import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';
import '../enums/italian_tense.dart';
import 'conjugation.dart';
import 'tense.dart';

/// => Imperativo Positivo
final class PositiveImperative extends Tense {
  static const String jsonKey = 'positivo';
  PositiveImperative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.positiveImperative);

  factory PositiveImperative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugations[pronoun]!);
    }

    return PositiveImperative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
  
  // TODO Remove from here
  /*factory PositiveImperative.fromJson(Map<String, dynamic> json) {
    return PositiveImperative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Imperativo Negativo
final class NegativeImperative extends Tense {
  NegativeImperative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.negativeImperative);

  factory NegativeImperative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return NegativeImperative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}