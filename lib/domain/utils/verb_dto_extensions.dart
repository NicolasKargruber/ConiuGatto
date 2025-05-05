import '../../data/enums/pronoun.dart';
import '../../data/models/verb_dto.dart';
import '../models/tenses/imperative_tenses.dart';
import '../models/tenses/tense.dart';

extension GenerateIndicative on VerbDTO {
  String get italianInfinitive => infinitive.italian; // ex. 'parlare'
  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ex. 'ARE' | 'ERE' | 'IRE'

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
}

extension GenerateSubjunctive on VerbDTO {
  String get italianInfinitive => infinitive.italian; // ex. 'parlare'
  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ex. 'ARE' | 'ERE' | 'IRE'

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
}

extension GenerateConditional on VerbDTO {
  String get italianInfinitive => infinitive.italian; // ex. 'parlare'
  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ex. 'ARE' | 'ERE' | 'IRE'

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
}

extension GenerateImperative on VerbDTO {
  String get italianInfinitive => infinitive.italian; // ex. 'parlare'
  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ex. 'ARE' | 'ERE' | 'IRE'

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
    return NegativeImperative.from(conjugations: conjugations, generated: _generatedNegativeImperative);
  }

  /// => GENERATED Imperativo Negativo
  GeneratedConjugations get _generatedNegativeImperative {
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
}