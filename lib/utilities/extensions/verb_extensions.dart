import '../../data/compound_verbs.dart';
import '../../models/auxiliary.dart';
import '../../models/moods/base_tense.dart';
import '../../models/pronoun.dart';
import '../../models/verb.dart';

extension GenerateIndicative on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  /// => Presente Progressivo
  Conjugations get presentContinuous {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateStare(pronoun)!} $presentGerund",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Passato Prossimo
  Conjugations presentPerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.present)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Prossimo
  Conjugations pastPerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.imperfect)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Remoto
  Conjugations historicalPastPerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.historicalPresentPerfect)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Futuro Anteriore
  Conjugations futurePerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.future)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateSubjunctive on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  /// => Congiuntivo Passato
  Conjugations presentPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.presentSubjunctive)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Congiuntivo Trapassato
  Conjugations pastPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.imperfectSubjunctive)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

    return Conjugations.fromEntries(Pronoun.values.map(conjugate));
  }
}

extension GenerateConditional on Verb {
  static final _compoundVerbs = CompoundVerbs.instance;

  /// => Condizionale Passato
  Conjugations presentPerfectConditional(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => MapEntry(
      pronoun,
      "${_compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.presentConditional)!} ${auxiliary == Auxiliary.essere ? pastParticipleWithGender(pronoun) : pastParticiple}",
    );

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
          return "non $infinitive";
        default:
          return "non $conjugation";
      }
    });
  }
}
