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
    final italianPastParticiple = conditionallyGenderParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return Conjugation(pronoun, (
      italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
      english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  MapEntry<Pronoun, String> _conjugateGenerated(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final italianPastParticiple = conditionallyGenderGenderedParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return MapEntry(pronoun, "$conjugatedItalianAuxiliary $italianPastParticiple");
  }

  ItalianConjugations get generatedPresentIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'o' : ending == 'ERE' ? 'o' : 'o'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'i' : ending == 'ERE' ? 'i' : 'i'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'a' : ending == 'ERE' ? 'e' : 'e'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'iamo' : ending == 'ERE' ? 'iamo' : 'iamo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'ate' : ending == 'ERE' ? 'ete' : 'ite'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'ano' : ending == 'ERE' ? 'ono' : 'ono'}",
    };
  }

  /// => Presente Progressivo
  PresentContinuousIndicative get presentContinuous {
    conjugate(Pronoun pronoun) => Conjugation(pronoun, (italian: "${_compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${_compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}"));
    return PresentContinuousIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  ItalianConjugations get generatedPresentContinuousIndicative {
    conjugate(Pronoun pronoun) => MapEntry(pronoun, "${_compoundVerbs.conjugateStare(pronoun)!} $generatedPresentGerund");
    return ItalianConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Passato Prossimo
  PresentPerfectIndicative presentPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.present);
    return PresentPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  ItalianConjugations generatedPresentPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _conjugateGenerated(pronoun, auxiliary, SimpleTense.present);
    return ItalianConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Prossimo
  PastPerfectIndicative pastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.imperfect);
    return PastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  ItalianConjugations generatedPastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _conjugateGenerated(pronoun, auxiliary, SimpleTense.imperfect);
    return ItalianConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  ItalianConjugations get generatedImperfectIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'avo' : ending == 'ERE' ? 'evo' : 'ivo'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'avi' : ending == 'ERE' ? 'evi' : 'ivi'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'ava' : ending == 'ERE' ? 'eva' : 'iva'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'avamo' : ending == 'ERE' ? 'evamo' : 'ivamo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'avate' : ending == 'ERE' ? 'evate' : 'ivate'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'avano' : ending == 'ERE' ? 'evano' : 'ivano'}"
    };
  }

  ItalianConjugations get generatedHistoricalPresentPerfectIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'ai' : ending == 'ERE' ? 'ei' : 'ei'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'asti' : ending == 'ERE' ? 'esti' : 'esti'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'ò' : ending == 'ERE' ? 'é' : 'ì'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'ammo' : ending == 'ERE' ? 'emmo' : 'immo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'aste' : ending == 'ERE' ? 'este' : 'iste'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'arono' : ending == 'ERE' ? 'erono' : 'irono'}"
    };
  }

  /// => Trapassato Remoto
  HistoricalPastPerfectIndicative historicalPastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.historicalPresentPerfect);
    return HistoricalPastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  ItalianConjugations generatedHistoricalPastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _conjugateGenerated(pronoun, auxiliary, SimpleTense.historicalPresentPerfect);
    return ItalianConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  ItalianConjugations get generatedFutureIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'erò' : ending == 'ERE' ? 'erò' : 'irò'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'erai' : ending == 'ERE' ? 'erai' : 'irai'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'erà' : ending == 'ERE' ? 'erà' : 'irà'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'eremo' : ending == 'ERE' ? 'eremo' : 'iremo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'erete' : ending == 'ERE' ? 'erete' : 'irete'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'eranno' : ending == 'ERE' ? 'eranno' : 'iranno'}"
    };
  }

  /// => Futuro Anteriore
  FuturePerfectIndicative futurePerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.future);
    return FuturePerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  ItalianConjugations generatedFuturePerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _conjugateGenerated(pronoun, auxiliary, SimpleTense.future);
    return ItalianConjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateSubjunctive on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = conditionallyGenderParticiple(pronoun: pronoun, auxiliary: auxiliary);
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
    final italianPastParticiple = conditionallyGenderParticiple(auxiliary: auxiliary, pronoun: pronoun);

    conditionallyGenderParticiple(pronoun: pronoun, auxiliary: auxiliary);
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
          return (italian: "non $italianInfinitive", english: conjugation.english.replaceAll(")", ") don't"));
          case Pronoun.firstPlural:
          return (italian: "non ${conjugation.italian}", english: conjugation.english.replaceAll("let's ", "let's not "));
        default:
          return (italian: "non ${conjugation.italian}", english: conjugation.english.replaceAll(")", ") don't"));
      }
    });
    return NegativeImperative(conjugations: conjugations);
  }
}
