import 'auxiliary.dart';
import 'moods/conditional.dart';
import 'moods/imperative.dart';
import 'moods/indicative.dart';
import 'moods/mood.dart';
import 'moods/subjunctive.dart';
import 'pronoun.dart';
import 'regularity.dart';

typedef Conjugations = Map<Pronoun, ({String italian, String english})?>;
typedef Conjugation = MapEntry<Pronoun, ({String italian, String english})?>;

class Verb {
  final String infinitive;
  final String translation;
  final Regularity regularity;
  final List<Auxiliary> auxiliaries;

  // Moods
  final Indicative indicative;
  final Subjunctive subjunctive;
  final Conditional conditional;
  final Imperative imperative;
  List<Mood> get moods => [indicative, subjunctive, conditional, imperative];

  final ({String italian, String english}) pastParticiple;
  final ({String italian, String english}) presentGerund;

  String pastParticipleWithGender(Pronoun pronoun) => pronoun.isPlural ?
      pastParticiple.italian.replaceAll('o', 'i/e') : pastParticiple.italian.replaceAll('o', 'o/a');

  // TODO use this
   ({String name, int age})? _verbConjugationFromJson(Map<String, dynamic> json){}

  Verb({
    required this.infinitive,
    required this.translation,
    required this.regularity,
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
      infinitive: json['infinitive'],
      translation: json['translation'],
      regularity: Regularity.fromJson(json['regularity']),
      auxiliaries: (json['auxiliaries'] as List).map((e) => Auxiliary.fromJson(e)).toList(),
      indicative: Indicative.fromJson(json['conjugations']['indicativo']),
      subjunctive: Subjunctive.fromJson(json['conjugations']['congiuntivo']),
      conditional: Conditional.fromJson(json['conjugations']['condizionale']),
      imperative: Imperative.fromJson(json['conjugations']['imperativo']),
      pastParticiple: (italian: json['participio_passato']['italian'], english: json['participio_passato']['english']),
      presentGerund: (italian: json['gerundio_presente']['italian'], english: json['gerundio_presente']['english']),
    );
  }
}
