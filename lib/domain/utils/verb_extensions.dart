import '../../data/models/tense_dto.dart';
import '../../data/models/verb_dto.dart';
import '../../data/utils/pronoun_extensions.dart';
import '../models/compound_verbs.dart';
import '../../data/enums/auxiliary.dart';
import '../../data/enums/pronoun.dart';
import '../models/enums/simple_tense.dart';
import '../models/tenses/conditional_tenses.dart';
import '../models/tenses/indicative_tenses.dart';
import '../models/tenses/subjunctive_tenses.dart';
import '../models/tenses/tense.dart';
import '../models/verb.dart';

extension GenerateTenses on Verb {
  String get _generatePastParticiple => "$stem${ending == 'ARE' ? 'ato' : ending == 'ERE' ? 'uto' : 'ito'}";
  String get _generatePresentGerund => "$stem${ending == 'ARE' ? 'ando' : ending == 'ERE' ? 'endo' : 'endo'}";

  bool get hasIrregularParticiple => pastParticiple.italian != _generatePastParticiple;
  bool get hasIrregularGerund => presentGerund.italian != _generatePastParticiple;

  String conditionallyGenderParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(pastParticiple.italian, forceGender: true): pastParticiple.italian;

  String conditionallyGenderGenderedParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(_generatePastParticiple, forceGender: true): _generatePastParticiple;
  
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
  /// => Presente Progressivo
  PresentContinuousIndicative get presentContinuousIndicative {
    final compoundVerbs = CompoundVerbs.instance;
    conjugate(Pronoun pronoun) => Conjugation(pronoun, (italian: "${compoundVerbs.conjugateStare(pronoun)!} ${presentGerund.italian}", english: "${compoundVerbs.conjugateStareInEnglish(pronoun)!} ${presentGerund.english}"));
    return PresentContinuousIndicative.from(
        conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
        generated: _generatePresentContinuousIndicative,
    );
  }

  /// => GENERATED Presente Progressivo
  GeneratedConjugations get _generatePresentContinuousIndicative {
    final compoundVerbs = CompoundVerbs.instance;
    conjugate(Pronoun pronoun) => MapEntry(pronoun, "${compoundVerbs.conjugateStare(pronoun)!} $_generatePresentGerund");
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Passato Prossimo
  PresentPerfectIndicative presentPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentIndicative);
    return PresentPerfectIndicative.from(
      conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
      generated: _generatePresentPerfectIndicative(auxiliary),
    );
  }

  /// => GENERATED Passato Prossimo
  GeneratedConjugations _generatePresentPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Prossimo
  PastPerfectIndicative pastPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.imperfectIndicative);
    return PastPerfectIndicative.from(
      conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
      generated: _generatePastPerfectIndicative(auxiliary),
    );
  }

  /// => GENERATED Trapassato Prossimo
  GeneratedConjugations _generatePastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.imperfectIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Trapassato Remoto
  HistoricalPastPerfectIndicative historicalPastPerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.historicalPresentPerfectIndicative);
    return HistoricalPastPerfectIndicative.from(
        conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
        generated: _generateHistoricalPastPerfectIndicative(auxiliary),
    );
  }

  /// => GENERATED Trapassato Remoto
  GeneratedConjugations _generateHistoricalPastPerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.historicalPresentPerfectIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Futuro Anteriore
  FuturePerfectIndicative futurePerfectIndicative(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.futureIndicative);
    return FuturePerfectIndicative.from(
        conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
        generated: _generateFuturePerfectIndicative(auxiliary),
    );
  }

  /// => GENERATED Futuro Anteriore
  GeneratedConjugations _generateFuturePerfectIndicative(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.futureIndicative);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getIndicativeTenses(Auxiliary auxiliary) {
    return [
          presentIndicative,
          presentContinuousIndicative,
          imperfectIndicative,
          presentPerfectIndicative(auxiliary),
          pastPerfectIndicative(auxiliary),
          historicalPresentPerfectIndicative,
          historicalPastPerfectIndicative(auxiliary),
          futureIndicative,
          futurePerfectIndicative(auxiliary),
    ];
  }
}

extension GenerateSubjunctive on Verb {
  /// => Congiuntivo Passato
  PresentPerfectSubjunctive presentPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return PresentPerfectSubjunctive.from(
      conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
    generated: _generatePresentPerfectSubjunctive(auxiliary),
    );
  }

  /// => GENERATED Congiuntivo Passato
  GeneratedConjugations _generatePresentPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentSubjunctive);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  /// => Congiuntivo Trapassato
  PastPerfectSubjunctive pastPerfectSubjunctive(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return PastPerfectSubjunctive.from(
        conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
        generated: _generatePastPerfectSubjunctive(auxiliary),
    );
  }

  /// GENERATED Congiuntivo Trapassato
  GeneratedConjugations _generatePastPerfectSubjunctive(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.imperfectSubjunctive);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getSubjunctiveTenses(Auxiliary auxiliary) {
    return [
      presentSubjunctive,
      imperfectSubjunctive,
      presentPerfectSubjunctive(auxiliary),
      pastPerfectSubjunctive(auxiliary),
    ];
  }
}

extension GenerateConditional on Verb {
  /// => Condizionale Passato
  PresentPerfectConditional presentPerfectConditional(Auxiliary auxiliary) {
    Conjugation conjugate(Pronoun pronoun) => _conjugateCompound(pronoun, auxiliary, SimpleTense.presentConditional);
    return PresentPerfectConditional.from(
        conjugations: Conjugations.fromEntries(Pronoun.values.map(conjugate)),
        generated: _generatePresentPerfectConditional(auxiliary),
    );
  }

  /// => GENERATED Condizionale Passato
  GeneratedConjugations _generatePresentPerfectConditional(Auxiliary auxiliary) {
    conjugate(Pronoun pronoun) => _generateAndConjugate(pronoun, auxiliary, SimpleTense.presentConditional);
    return GeneratedConjugations.fromEntries(Pronoun.values.map(conjugate));
  }

  List<Tense> getConditionalTenses(Auxiliary auxiliary) {
    return [
      presentConditional,
      presentPerfectConditional(auxiliary),
    ];
  }
}

extension GenerateImperative on Verb {
  List<Tense> getImperativeTenses() {
    return [
      positiveImperative,
      negativeImperative,
    ];
  }
}
