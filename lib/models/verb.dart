import 'package:collection/collection.dart';

import '../utilities/extensions/verb_extensions.dart';
import 'auxiliary.dart';
import 'base_verb.dart';
import 'irregularity.dart';
import 'pronoun.dart';
import 'regularity.dart';
import 'tenses/conditional_tenses.dart';
import 'tenses/imperative_tenses.dart';
import 'tenses/indicative_tenses.dart';
import 'tenses/italian_tense.dart';
import 'tenses/subjunctive_tenses.dart';
import 'tenses/tense.dart';

typedef ConjugatedVerb = ({String italian, String english});
typedef Conjugation = MapEntry<Pronoun, ConjugatedVerb?>;
typedef Conjugations = Map<Pronoun, ConjugatedVerb?>;
typedef ItalianConjugations = Map<Pronoun, String?>;

class Verb extends BaseVerb {
  final ConjugatedVerb infinitive;
  final Regularity regularity;
  final Set<Irregularity> irregularities;
  final List<Auxiliary> auxiliaries;

  /// Used for Shared Preferences
  String get prefKey => italianInfinitive;

  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ARE, ERE, IRE
  String get italianInfinitive => infinitive.italian;
  String get translation => infinitive.english;
  bool get isRegular => regularity.isRegular;
  bool get isDoubleAuxiliary => UnorderedIterableEquality().equals(Auxiliary.values, auxiliaries);

  Tense Function(Auxiliary) getTense(ItalianTense tense) {
    return switch(tense) {
      ItalianTense.presentIndicative => (_) => presentIndicative,
      ItalianTense.presentContinuousIndicative => (_) => presentContinuousIndicative,
      ItalianTense.imperfectIndicative => (_) => imperfectIndicative,
      ItalianTense.presentPerfectIndicative => presentPerfectIndicative,
      ItalianTense.pastPerfectIndicative => pastPerfectIndicative,
      ItalianTense.historicalPresentPerfectIndicative => (_) => historicalPresentPerfectIndicative,
      ItalianTense.historicalPastPerfectIndicative => historicalPastPerfectIndicative,
      ItalianTense.futureIndicative => (_) => futureIndicative,
      ItalianTense.futurePerfectIndicative => futurePerfectIndicative,
      ItalianTense.presentSubjunctive => (_) => presentSubjunctive,
      ItalianTense.imperfectSubjunctive => (_) => imperfectSubjunctive,
      ItalianTense.presentPerfectSubjunctive => presentPerfectSubjunctive,
      ItalianTense.pastPerfectSubjunctive => pastPerfectSubjunctive,
      ItalianTense.presentConditional => (_) => presentConditional,
      ItalianTense.presentPerfectConditional => presentPerfectConditional,
      ItalianTense.positiveImperative => (_) => positiveImperative,
      ItalianTense.negativeImperative => (_) => negativeImperative,
    };
  }

  final ConjugatedVerb pastParticiple;
  String get _generatedPastParticiple => "$stem${ending == 'ARE' ? 'ato' : ending == 'ERE' ? 'uto' : 'ito'}";
  final ConjugatedVerb presentGerund;
  String get generatedPresentGerund => "$stem${ending == 'ARE' ? 'ando' : ending == 'ERE' ? 'endo' : 'endo'}";

  String conditionallyGenderParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(pastParticiple.italian, forceGender: true): pastParticiple.italian;

  String conditionallyGenderGenderedParticiple({required Auxiliary auxiliary, required Pronoun pronoun}) =>
      auxiliary.requiresGenderedParticiple ? pronoun.genderItalianConjugationIfPossible(_generatedPastParticiple, forceGender: true): _generatedPastParticiple;


  Verb({
    required this.infinitive,
    required this.regularity,
    required this.irregularities,
    required this.auxiliaries,
    required super.presentIndicative,
    required super.imperfectIndicative,
    required super.historicalPresentPerfectIndicative,
    required super.futureIndicative,
    required super.presentSubjunctive,
    required super.imperfectSubjunctive,
    required super.presentConditional,
    required super.positiveImperative,
    required this.pastParticiple,
    required this.presentGerund,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: conjugatedVerbFrom(json['infinitive']),
      regularity: Regularity.fromJson(json['regularity']),
      irregularities: (json['irregularities'] as List? ?? []).map((e) => Irregularity.fromJson(e)).toSet(),
      auxiliaries: (json['auxiliaries'] as List).map((e) => Auxiliary.fromJson(e)).toList(),
      presentIndicative: PresentIndicative.fromJson(json['conjugations']['indicativo']),
      imperfectIndicative: ImperfectIndicative.fromJson(json['conjugations']['indicativo']),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.fromJson(json['conjugations']['indicativo']),
      futureIndicative: FutureIndicative.fromJson(json['conjugations']['indicativo']),
      presentSubjunctive: PresentSubjunctive.fromJson(json['conjugations']['congiuntivo']),
      imperfectSubjunctive: ImperfectSubjunctive.fromJson(json['conjugations']['congiuntivo']),
      presentConditional: PresentConditional.fromJson(json['conjugations']['condizionale']),
      positiveImperative: PositiveImperative.fromJson(json['conjugations']['imperativo']),
      pastParticiple: conjugatedVerbFrom(json['participio_passato']),
      presentGerund: conjugatedVerbFrom(json['gerundio_presente']),
    );
  }
}

conjugatedVerbFrom(dynamic json) => (italian: json['italian'], english: json['english']);
