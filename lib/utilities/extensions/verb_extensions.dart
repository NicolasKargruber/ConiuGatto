import 'package:coniugatto/models/tense.dart';

import '../../data/compound_verbs.dart';
import '../../models/auxiliary.dart';
import '../../models/moods/simple_tense.dart';
import '../../models/pronoun.dart';
import '../../models/verb.dart';

extension GenerateIndicative on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
      italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
      english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Presente Progressivo
  Tense get presentContinuous {
    conjugate(Pronoun pronoun) => Conjugation(
      pronoun,
        (italian: "${_compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${_compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}")
      ,
    );

    return Tense(name: 'Presente Progressivo', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Passato Prossimo
  Tense presentPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.present);
    return Tense(name: 'Passato Prossimo', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Trapassato Prossimo
  Tense pastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.imperfect);
    return Tense(name: 'Trapassato Prossimo', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Trapassato Remoto
  Tense historicalPastPerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.historicalPresentPerfect);
    return Tense(name: 'Trapassato Remoto', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Futuro Anteriore
  Tense futurePerfect(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.future);
    return Tense(name: 'Futuro Anteriore', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateSubjunctive on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Congiuntivo Passato
  Tense presentPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return Tense(name: 'Congiuntivo Passato', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }

  /// => Congiuntivo Trapassato
  Tense pastPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return Tense(name: 'Congiuntivo Trapassato', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateConditional on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  _conjugate(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final conjugatedItalianAuxiliary = _compoundVerbs.conjugateItalianAuxiliary(pronoun, auxiliary, tense);
    final conjugatedEnglishAuxiliary = _compoundVerbs.conjugateEnglishAuxiliary(pronoun, tense);
    final italianPastParticiple = auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple.italian;
    return Conjugation(pronoun, (
    italian: "$conjugatedItalianAuxiliary $italianPastParticiple",
    english: "$conjugatedEnglishAuxiliary ${pastParticiple.english}",
    ));
  }

  /// => Condizionale Passato
  Tense presentPerfectConditional(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugate(pronoun, auxiliary, SimpleTense.presentConditional);
    return Tense(name: 'Condizionale Passato', conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)));
  }
}

extension GenerateImperative on Verb {
  /// => Imperativo Negativo
  Tense get negativeImperative {
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
    return Tense(name: 'Negativo', conjugations: conjugations);
  }
}
