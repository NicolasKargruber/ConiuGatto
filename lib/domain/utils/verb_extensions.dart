import '../../data/compound_verbs.dart';
import '../../data/enums/auxiliary.dart';
import '../../data/enums/pronoun.dart';
import '../../data/enums/simple_tense.dart';
import '../../data/models/tenses/conditional_tenses.dart';
import '../../data/models/tenses/imperative_tenses.dart';
import '../../data/models/tenses/indicative_tenses.dart';
import '../../data/models/tenses/subjunctive_tenses.dart';
import '../../data/models/tenses/tense.dart';
import '../../data/models/verb.dart';

extension GenerateTenses on Verb {
  String get _generatedPastParticiple => "$stem${ending == 'ARE' ? 'ato' : ending == 'ERE' ? 'uto' : 'ito'}";
  String get _generatedPresentGerund => "$stem${ending == 'ARE' ? 'ando' : ending == 'ERE' ? 'endo' : 'endo'}";

  String conditionallyGenderParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(pastParticiple.italian, forceGender: true): pastParticiple.italian;

  String conditionallyGenderGenderedParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(_generatedPastParticiple, forceGender: true): _generatedPastParticiple;
  
  static final _compoundVerbs = CompoundVerbs.instance;
  _conjugateCompound(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = conditionallyGenderParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }
  
  MapEntry<Pronoun, String> _generateAndConjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final italianPastParticiple = conditionallyGenderGenderedParticiple(pronoun: pronoun, auxiliary: auxiliary);
    return MapEntry(pronoun, "$conjugatedItalianAuxiliary $italianPastParticiple");
  }
}

extension GenerateIndicative on Verb {
  /// => GENERATED Presente
  GeneratedConjugations get generatedPresentIndicative {
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
  PresentContinuousIndicative get presentContinuousIndicative {
    final compoundVerbs = CompoundVerbs.instance;
    conjugate(Pronoun pronoun) => Conjugation(pronoun, (italian: "${compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}"));
    return PresentContinuousIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Presente Progressivo
  GeneratedConjugations get generatedPresentContinuousIndicative {
    final compoundVerbs = CompoundVerbs.instance;
    conjugate(Pronoun pronoun) => MapEntry(pronoun, "${compoundVerbs.conjugateStare(pronoun)!} $_generatedPresentGerund");
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Passato Prossimo
  PresentPerfectIndicative presentPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentIndicative);
    return PresentPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Passato Prossimo
  GeneratedConjugations generatedPresentPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Prossimo
  PastPerfectIndicative pastPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.imperfectIndicative);
    return PastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Trapassato Prossimo
  GeneratedConjugations generatedPastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.imperfectIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => GENERATED Imperfetto
  GeneratedConjugations get generatedImperfectIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'avo' : ending == 'ERE' ? 'evo' : 'ivo'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'avi' : ending == 'ERE' ? 'evi' : 'ivi'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'ava' : ending == 'ERE' ? 'eva' : 'iva'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'avamo' : ending == 'ERE' ? 'evamo' : 'ivamo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'avate' : ending == 'ERE' ? 'evate' : 'ivate'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'avano' : ending == 'ERE' ? 'evano' : 'ivano'}"
    };
  }

  /// => GENERATED Passato Remoto
  GeneratedConjugations get generatedHistoricalPresentPerfectIndicative {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'ai' : ending == 'ERE' ? 'ei' : 'ii'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'asti' : ending == 'ERE' ? 'esti' : 'isti'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'ò' : ending == 'ERE' ? 'é' : 'ì'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'ammo' : ending == 'ERE' ? 'emmo' : 'immo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'aste' : ending == 'ERE' ? 'este' : 'iste'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'arono' : ending == 'ERE' ? 'erono' : 'irono'}"
    };
  }

  /// => Trapassato Remoto
  HistoricalPastPerfectIndicative historicalPastPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.historicalPresentPerfectIndicative);
    return HistoricalPastPerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Trapassato Remoto
  GeneratedConjugations generatedHistoricalPastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.historicalPresentPerfectIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => GENERATED Futuro Semplice
  GeneratedConjugations get generatedFutureIndicative {
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
  FuturePerfectIndicative futurePerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.futureIndicative);
    return FuturePerfectIndicative(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Futuro Anteriore
  GeneratedConjugations generatedFuturePerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.futureIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getIndicativeTenses(Auxiliary auxiliary, {bool includeGenerated = false}) {
    return [
          presentIndicative..generatedConjugations = includeGenerated ? generatedPresentIndicative : null ..setItalianConjugationsParted(),
          presentContinuousIndicative..generatedConjugations = includeGenerated ? generatedPresentContinuousIndicative : null ..setItalianConjugationsParted(),
          imperfectIndicative..generatedConjugations = includeGenerated ? generatedImperfectIndicative : null ..setItalianConjugationsParted(),
          presentPerfectIndicative(auxiliary)..generatedConjugations = includeGenerated ? generatedPresentPerfectIndicative(auxiliary) : null ..setItalianConjugationsParted(),
          pastPerfectIndicative(auxiliary)..generatedConjugations = includeGenerated ? generatedPastPerfectIndicative(auxiliary) : null ..setItalianConjugationsParted(),
          historicalPresentPerfectIndicative..generatedConjugations = includeGenerated ? generatedHistoricalPresentPerfectIndicative : null ..setItalianConjugationsParted(),
          historicalPastPerfectIndicative(auxiliary)..generatedConjugations = includeGenerated ? generatedHistoricalPastPerfectIndicative(auxiliary) : null ..setItalianConjugationsParted(),
          futureIndicative..generatedConjugations = includeGenerated ? generatedFutureIndicative : null ..setItalianConjugationsParted(),
          futurePerfectIndicative(auxiliary)..generatedConjugations = includeGenerated ? generatedFuturePerfectIndicative(auxiliary) : null ..setItalianConjugationsParted(),
    ];
  }
}

extension GenerateSubjunctive on Verb {
  /// => GENERATED Congiuntivo Presente
  GeneratedConjugations get generatedPresentSubjunctive {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'i' : ending == 'ERE' ? 'a' : 'a'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'i' : ending == 'ERE' ? 'a' : 'a'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'i' : ending == 'ERE' ? 'a' : 'a'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'iamo' : ending == 'ERE' ? 'iamo' : 'iamo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'iate' : ending == 'ERE' ? 'iate' : 'iate'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'ino' : ending == 'ERE' ? 'ano' : 'ano'}"
    };
  }

  /// => GENERATED Congiuntivo Imperfetto
  GeneratedConjugations get generatedImperfectSubjunctive {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'assi' : ending == 'ERE' ? 'essi' : 'issi'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'assi' : ending == 'ERE' ? 'essi' : 'issi'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'asse' : ending == 'ERE' ? 'esse' : 'isse'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'assimo' : ending == 'ERE' ? 'essimo' : 'issimo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'aste' : ending == 'ERE' ? 'este' : 'iste'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'assero' : ending == 'ERE' ? 'essero' : 'issero'}"
    };
  }

  /// => Congiuntivo Passato
  PresentPerfectSubjunctive presentPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return PresentPerfectSubjunctive(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Congiuntivo Passato
  GeneratedConjugations generatedPresentPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Congiuntivo Trapassato
  PastPerfectSubjunctive pastPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return PastPerfectSubjunctive(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// GENERATED Congiuntivo Trapassato
  GeneratedConjugations generatedPastPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getSubjunctiveTenses(Auxiliary auxiliary, {bool includeGenerated = false}) {
    return [
      presentSubjunctive..generatedConjugations = includeGenerated ? generatedPresentSubjunctive : null ..setItalianConjugationsParted(),
      imperfectSubjunctive..generatedConjugations = includeGenerated ? generatedImperfectSubjunctive : null ..setItalianConjugationsParted(),
      presentPerfectSubjunctive(auxiliary)..generatedConjugations = includeGenerated ? generatedPresentPerfectSubjunctive(auxiliary) : null ..setItalianConjugationsParted(),
      pastPerfectSubjunctive(auxiliary)..generatedConjugations = includeGenerated ? generatedPastPerfectSubjunctive(auxiliary) : null ..setItalianConjugationsParted(),
    ];
  }
}

extension GenerateConditional on Verb {
  /// => GENERATED Condizionale Presente
  GeneratedConjugations get generatedPresentConditional {
    return {
      Pronoun.firstSingular: "$stem${ending == 'ARE' ? 'erei' : ending == 'ERE' ? 'erei' : 'irei'}",
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'eresti' : ending == 'ERE' ? 'eresti' : 'iresti'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'erebbe' : ending == 'ERE' ? 'erebbe' : 'irebbe'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'eremmo' : ending == 'ERE' ? 'eremmo' : 'iremmo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'ereste' : ending == 'ERE' ? 'ereste' : 'ireste'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'erebbero' : ending == 'ERE' ? 'erebbero' : 'irebbero'}"
    };
  }

  /// => Condizionale Passato
  PresentPerfectConditional presentPerfectConditional(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentConditional);
    return PresentPerfectConditional(conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => GENERATED Condizionale Passato
  GeneratedConjugations generatedPresentPerfectConditional(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentConditional);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getConditionalTenses(Auxiliary auxiliary, {bool includeGenerated = false}) {
    return [
      presentConditional..generatedConjugations = includeGenerated ? generatedPresentConditional : null ..setItalianConjugationsParted(),
      presentPerfectConditional(auxiliary)..generatedConjugations = includeGenerated ? generatedPresentPerfectConditional(auxiliary) : null ..setItalianConjugationsParted(),
    ];
  }
}

extension GenerateImperative on Verb {
  /// => GENERATED Imperativo Positivo
  GeneratedConjugations get generatedPositiveImperative {
    return {
      Pronoun.firstSingular: null,
      Pronoun.secondSingular: "$stem${ending == 'ARE' ? 'a' : ending == 'ERE' ? 'i' : 'i'}",
      Pronoun.thirdSingular: "$stem${ending == 'ARE' ? 'i' : ending == 'ERE' ? 'a' : 'a'}",
      Pronoun.firstPlural: "$stem${ending == 'ARE' ? 'iamo' : ending == 'ERE' ? 'iamo' : 'iamo'}",
      Pronoun.secondPlural: "$stem${ending == 'ARE' ? 'ate' : ending == 'ERE' ? 'ete' : 'ite'}",
      Pronoun.thirdPlural: "$stem${ending == 'ARE' ? 'ino' : ending == 'ERE' ? 'ano' : 'ano'}"
    };
  }

  /// => Imperativo Negativo
  NegativeImperative get negativeImperative {
    // Clone (..) and update
    final conjugations = {...positiveImperative.conjugations}..updateAll((pronoun, conjugation) {
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

  /// => GENERATED Imperativo Negativo
  GeneratedConjugations get generatedNegativeImperative {
    // Clone (..) and update
    final conjugations = {...generatedPositiveImperative}..updateAll((pronoun, conjugation) {
        if (conjugation == null) return null;
        switch (pronoun) {
          case Pronoun.secondSingular:
            return "non $italianInfinitive";
          default:
            return "non $conjugation";
        }
      });
    return conjugations;
  }

  List<Tense> getImperativeTenses({bool includeGenerated = false}) {
    return [
      positiveImperative..generatedConjugations = includeGenerated ? generatedPositiveImperative : null ..setItalianConjugationsParted(),
      negativeImperative..generatedConjugations = includeGenerated ? generatedNegativeImperative : null ..setItalianConjugationsParted(),
    ];
  }
}
