import '../../data/compound_verbs.dart';
import '../../models/auxiliary.dart';
import '../../models/moods/base_tense.dart';
import '../../models/pronoun.dart';
import '../../models/verb.dart';

extension GeneratedTenses on Verb {
  static final compoundVerbs = CompoundVerbs.instance;

  Conjugations presentPerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) =>
        MapEntry(pronoun, "${compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.present)!} $pastParticiple");

    return <Pronoun, String?>{}..addEntries([
      conjugate(Pronoun.firstSingular),
      conjugate(Pronoun.secondSingular),
      conjugate(Pronoun.thirdSingular),
      conjugate(Pronoun.firstPlural),
      conjugate(Pronoun.secondPlural),
      conjugate(Pronoun.thirdPlural),
    ]);
  }

  Conjugations pastPerfect(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) =>
        MapEntry(pronoun, "${compoundVerbs.conjugateAuxiliary(pronoun, auxiliary, BaseTense.imperfect)!} $pastParticiple");

    return <Pronoun, String?>{}..addEntries([
      conjugate(Pronoun.firstSingular),
      conjugate(Pronoun.secondSingular),
      conjugate(Pronoun.thirdSingular),
      conjugate(Pronoun.firstPlural),
      conjugate(Pronoun.secondPlural),
      conjugate(Pronoun.thirdPlural),
    ]);
  }
}