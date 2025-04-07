import '../../data/compound_verbs.dart';
import '../../models/auxiliary.dart';
import '../../models/moods/base_tense.dart';
import '../../models/pronoun.dart';
import '../../models/verb.dart';

extension GenerateIndicative on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, BaseTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
      italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
      english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Presente Progressivo
  Conjugations get presentContinuous {
    conjugate(Pronoun pronoun) => Conjugation(
      pronoun,
        (italian: "${_compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${_compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}")
      ,
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Passato Prossimo
  Conjugations presentPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.present);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Prossimo
  Conjugations pastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.imperfect);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Remoto
  Conjugations historicalPastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.historicalPresentPerfect);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Futuro Anteriore
  Conjugations futurePerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.future);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateSubjunctive on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, BaseTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Congiuntivo Passato
  Conjugations presentPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.presentSubjunctive);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Congiuntivo Trapassato
  Conjugations pastPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.imperfectSubjunctive);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateConditional on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, BaseTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Condizionale Passato
  Conjugations presentPerfectConditional(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, BaseTense.presentConditional);
    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateImperative on Verb {
  /// => Imperativo Negativo
  Conjugations get negativeImperative {
    // Clone (..) and update
    return {...imperative.positive}..updateAll((pronoun, conjugation) {
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
  }
}
