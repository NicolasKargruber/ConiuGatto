import '../../models/tenses/subjunctive_tenses.dart';

import '../../data/compound_verbs.dart';
import '../../models/auxiliary.dart';
import '../../models/moods/simple_tense.dart';
import '../../models/pronoun.dart';
import '../../models/tenses/conditional_tenses.dart';
import '../../models/tenses/imperative_tenses.dart';
import '../../models/tenses/indicative_tenses.dart';
import '../../models/verb.dart';

extension GenerateIndicative on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = conditionallyGenderedParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return Conjugation(pronoun, (
      italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
      english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Presente Progressivo
  PresentContinuousIndicative get presentContinuous {
    conjugate(Pronoun pronoun) => Conjugation(pronoun, (italian: "${_compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${_compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}"));
    return PresentContinuousIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Passato Prossimo
  PresentPerfectIndicative presentPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.present);
    return PresentPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Trapassato Prossimo
  PastPerfectIndicative pastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.imperfect);
    return PastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Trapassato Remoto
  HistoricalPastPerfectIndicative historicalPastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.historicalPresentPerfect);
    return HistoricalPastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Futuro Anteriore
  FuturePerfectIndicative futurePerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.future);
    return FuturePerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateSubjunctive on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = conditionallyGenderedParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Congiuntivo Passato
  PresentPerfectSubjunctive presentPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return PresentPerfectSubjunctive(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Congiuntivo Trapassato
  PastPerfectSubjunctive pastPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return PastPerfectSubjunctive(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateConditional on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = conditionallyGenderedParticiple(auxiliary: auxiliary, pronoun: pronoun);

    conditionallyGenderedParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Condizionale Passato
  PresentPerfectConditional presentPerfectConditional(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.presentConditional);
    return PresentPerfectConditional(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateImperative on Verb {
  /// => Imperativo Negativo
  NegativeImperative get negativeImperative {
    // Clone (..) and update
    final conjugations = {...imperative.positive.conjugations}..updateAll((pronoun, conjugation) {
      if (conjugation == null) return null;
      switch (pronoun) {
        case Pronoun.secondSingular:
          return (italian: "non $infinitive", english: conjugation.english.replaceAll(")", ") don't"));
          case Pronoun.firstPlural:
          return (italian: "non ${conjugation.italian}", english: conjugation.english.replaceAll("let's ", "let's not "));
        default:
          return (italian: "non ${conjugation.italian}", english: conjugation.english.replaceAll(")", ") don't"));
      }
    });
    return NegativeImperative(conjugations: conjugations);
  }
}
