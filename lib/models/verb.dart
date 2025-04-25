import 'package:collection/collection.dart';

import 'auxiliary.dart';
import 'base_verb.dart';
import 'irregularity.dart';
import 'moods/conditional.dart';
import 'moods/imperative.dart';
import 'moods/indicative.dart';
import 'moods/mood.dart';
import 'moods/subjunctive.dart';
import 'pronoun.dart';
import 'regularity.dart';

typedef ConjugatedVerb = ({String italian, String english});
typedef Conjugation = MapEntry<Pronoun, ConjugatedVerb?>;
typedef Conjugations = Map<Pronoun, ConjugatedVerb?>;
typedef ItalianConjugations = Map<Pronoun, String?>;

class Verb implements BaseVerb {
  final ConjugatedVerb infinitive;
  final Regularity regularity;
  final Set<Irregularity> irregularities;
  final Set<Auxiliary> auxiliaries;

  /// Used for Shared Preferences
  String get prefKey => italianInfinitive;

  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ARE, ERE, IRE
  String get italianInfinitive => infinitive.italian;
  String get translation => infinitive.english;
  bool get isRegular => regularity.isRegular;
  bool get isDoubleAuxiliary => UnorderedIterableEquality().equals(Auxiliary.values, auxiliaries);

  // Moods
  @override
  final Indicative indicative;
  @override
  final Subjunctive subjunctive;
  @override
  final Conditional conditional;
  @override
  final Imperative imperative;
  List<Mood> get moods => [indicative, subjunctive, conditional, imperative];

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
    required this.indicative,
    required this.subjunctive,
    required this.conditional,
    required this.imperative,
    required this.pastParticiple,
    required this.presentGerund,
  }){
    indicative.verb = this;
    subjunctive.verb = this;
    conditional.verb = this;
    imperative.verb = this;
  }

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: conjugatedVerbFrom(json['infinitive']),
      regularity: Regularity.fromJson(json['regularity']),
      irregularities: (json['irregularities'] as List? ?? []).map((e) => Irregularity.fromJson(e)).toSet(),
      auxiliaries: (json['auxiliaries'] as List).map((e) => Auxiliary.fromJson(e)).toSet(),
      indicative: Indicative.fromJson(json['conjugations']['indicativo']),
      subjunctive: Subjunctive.fromJson(json['conjugations']['congiuntivo']),
      conditional: Conditional.fromJson(json['conjugations']['condizionale']),
      imperative: Imperative.fromJson(json['conjugations']['imperativo']),
      pastParticiple: conjugatedVerbFrom(json['participio_passato']),
      presentGerund: conjugatedVerbFrom(json['gerundio_presente']),
    );
  }
}

conjugatedVerbFrom(dynamic json) => (italian: json['italian'], english: json['english']);
