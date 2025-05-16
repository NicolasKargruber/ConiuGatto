import '../../../data/enums/pronoun.dart';
import '../../../data/models/verb_dto.dart';
import '../../../data/enums/italian_tense.dart';
import 'conjugation.dart';
import 'tense.dart';

/// => Indicativo Presente
final class PresentIndicative extends Tense {
  //static const String jsonKey = 'presente';
  PresentIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentIndicative);

  factory PresentIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return PresentIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory PresentIndicative.fromJson(Map<String, dynamic> json) {
    return PresentIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Indicativo Presente Progressivo
final class PresentContinuousIndicative extends Tense {
  PresentContinuousIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentContinuousIndicative, isCompound: true, );

  factory PresentContinuousIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return PresentContinuousIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}


/// => Indicativo Imperfetto
final class ImperfectIndicative extends Tense {
  //static const String jsonKey = 'imperfetto';
  ImperfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.imperfectIndicative);

  factory ImperfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return ImperfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory ImperfectIndicative.fromJson(Map<String, dynamic> json) {
    return ImperfectIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Indicativo Passato Prossimo
final class PresentPerfectIndicative extends Tense {
  PresentPerfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.presentPerfectIndicative, isCompound: true, usesPastParticiple: true);

  factory PresentPerfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return PresentPerfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}

/// => Indicativo Trapassato Prossimo
final class PastPerfectIndicative extends Tense {
  PastPerfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.pastPerfectIndicative, isCompound: true, usesPastParticiple: true);

  factory PastPerfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return PastPerfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}

/// => Indicativo Passato Remoto
final class HistoricalPresentPerfectIndicative extends Tense {
  //static const String jsonKey = "passato_remoto";
  HistoricalPresentPerfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.historicalPresentPerfectIndicative);

  factory HistoricalPresentPerfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return HistoricalPresentPerfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory HistoricalPresentPerfectIndicative.fromJson(Map<String, dynamic> json) {
    return HistoricalPresentPerfectIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Indicativo Trapassato Remoto
final class HistoricalPastPerfectIndicative extends Tense {
  HistoricalPastPerfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.historicalPastPerfectIndicative, isCompound: true, usesPastParticiple: true);

  factory HistoricalPastPerfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return HistoricalPastPerfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}

/// => Indicativo Futuro
final class FutureIndicative extends Tense {
  //static const String jsonKey = 'futuro_semplice';
  FutureIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.futureIndicative);

  factory FutureIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return FutureIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }

  /*factory FutureIndicative.fromJson(Map<String, dynamic> json) {
    return FutureIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }*/
}

/// => Indicativo Futuro Anteriore
final class FuturePerfectIndicative extends Tense {
  FuturePerfectIndicative({
    required super.firstConjugationSingular,
    required super.secondConjugationSingular,
    required super.thirdConjugationSingular,
    required super.firstConjugationPlural,
    required super.secondConjugationPlural,
    required super.thirdConjugationPlural,
  }) : super(type: ItalianTense.futurePerfectIndicative, isCompound: true, usesPastParticiple: true);

  factory FuturePerfectIndicative.from({required Conjugations conjugations, GeneratedConjugations? generated}) {
    // TODO Move to conjugations
    conjugationOrNull(Pronoun pronoun) {
      final conjugatedVerb = conjugations[pronoun];
      if(conjugatedVerb == null) return null;
      return Conjugation.from(pronoun: pronoun, generated: generated?[pronoun], conjugatedVerb: conjugatedVerb);
    }

    return FuturePerfectIndicative(
      firstConjugationSingular: conjugationOrNull(Pronoun.firstSingular),
      secondConjugationSingular: conjugationOrNull(Pronoun.secondSingular),
      thirdConjugationSingular: conjugationOrNull(Pronoun.thirdSingular),
      firstConjugationPlural: conjugationOrNull(Pronoun.firstPlural),
      secondConjugationPlural: conjugationOrNull(Pronoun.secondPlural),
      thirdConjugationPlural: conjugationOrNull(Pronoun.thirdPlural),
    );
  }
}

