import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';
import '../../../data/enums/italian_tense.dart';
import 'conjugation.dart';
import 'tense.dart';

/// => Congiuntivo Presente
final class PresentSubjunctive extends Tense {
  //static const String jsonKey = 'presente';
  PresentSubjunctive({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentSubjunctive);

  factory PresentSubjunctive.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugations[pronoun]!);
    }

    return PresentSubjunctive(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory PresentSubjunctive.fromJson(Map<String, dynamic> json) {
    return PresentSubjunctive(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Congiuntivo Imperfetto
final class ImperfectSubjunctive extends Tense {
  //static const String jsonKey = 'imperfetto';
  ImperfectSubjunctive({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.imperfectSubjunctive);

  factory ImperfectSubjunctive.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugations[pronoun]!);
    }

    return ImperfectSubjunctive(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory ImperfectSubjunctive.fromJson(Map<String, dynamic> json) {
    return ImperfectSubjunctive(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Congiuntivo Passato
final class PresentPerfectSubjunctive extends Tense {
  PresentPerfectSubjunctive({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentPerfectSubjunctive, isCompound: true, usesPastParticiple: true);

  factory PresentPerfectSubjunctive.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugations[pronoun]!);
    }

    return PresentPerfectSubjunctive(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}

/// => Congiuntivo Trapassato
final class PastPerfectSubjunctive extends Tense {
  PastPerfectSubjunctive({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.pastPerfectSubjunctive, isCompound: true, usesPastParticiple: true);

  factory PastPerfectSubjunctive.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    conjugationOrNull(Pronoun pronoun) {
      if(conjugations[pronoun] == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], translatedConjugation: conjugations[pronoun]!);
    }

    return PastPerfectSubjunctive(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}