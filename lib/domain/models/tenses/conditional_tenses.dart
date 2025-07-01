import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';
import '../../../data/enums/italian_tense.dart';
import 'conjugation.dart';
import 'tense.dart';

/// => Condizionale Presente
final class PresentConditional extends Tense {
  static const String jsonKey = 'presente';
  PresentConditional({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentConditional);

  factory PresentConditional.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugations[pronoun]!);
    }

    return PresentConditional(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory PresentConditional.fromJson(Map<String, dynamic> json) {
    return PresentConditional(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Condizionale Passato
final class PresentPerfectConditional extends Tense {
  PresentPerfectConditional({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentPerfectConditional, isCompound: true, usesPastParticiple: true);

  factory PresentPerfectConditional.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugatedVerb);
    }

    return PresentPerfectConditional(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}