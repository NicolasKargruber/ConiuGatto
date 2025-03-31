import 'package:coniugatto/models/auxiliary.dart';

import '../../data/compound_verbs.dart';
import '../pronoun.dart';
typedef Conjugations = Map<Pronoun, String?>;

class Indicative {
  final Conjugations present; // Presente
  // final Conjugation presente progresivo; // Present Continious
  final Conjugations imperfect; // Imperfecto
  // final Conjugation passato prossimo; // Present Perfect
  // final Conjugation trapassato prossimo; // Past Perfect
  final Conjugations historicalPresentPerfect; // Passato Remoto
  // final Conjugation trapassato remoto; // Historical Past Perfect
  final Conjugations simpleFuture; // Futuro Semplice
  // final Conjugation futuro prossimo; // Futuro GOING TO
  // final Conjugation futuro anteriore; // Futuro Perfect

  Conjugations presentPerfect(Auxiliary auxiliary, String pastParticiple) {
    return {
      Pronoun.firstSingular: "${CompoundVerbs.instance.getAuxiliary(Pronoun.firstSingular, auxiliary)!} $pastParticiple",
      Pronoun.secondSingular: "${CompoundVerbs.instance.getAuxiliary(Pronoun.secondSingular, auxiliary)!} $pastParticiple",
      Pronoun.thirdSingular: "${CompoundVerbs.instance.getAuxiliary(Pronoun.thirdSingular, auxiliary)!} $pastParticiple",
      Pronoun.firstPlural: "${CompoundVerbs.instance.getAuxiliary(Pronoun.firstPlural, auxiliary)!} $pastParticiple",
      Pronoun.secondPlural: "${CompoundVerbs.instance.getAuxiliary(Pronoun.secondPlural, auxiliary)!} $pastParticiple",
      Pronoun.thirdPlural: "${CompoundVerbs.instance.getAuxiliary(Pronoun.thirdPlural, auxiliary)!} $pastParticiple",
    };
}

  // Compound tenses will be generated dynamically
  Indicative({
    required this.present,
    required this.imperfect,
    required this.historicalPresentPerfect,
    required this.simpleFuture,
  });

  factory Indicative.fromJson(Map<String, dynamic> json) {
    return Indicative(
      present: parseConjugations(json['presente']),
      imperfect: parseConjugations(json['imperfetto']),
      historicalPresentPerfect: parseConjugations(json['passato_remoto']),
      simpleFuture: parseConjugations(json['futuro_semplice']),
    );
  }
}

Conjugations parseConjugations(Map<String, dynamic> json) {
  return {
    Pronoun.firstSingular: json[Pronoun.firstSingular.jsonKey()],
    Pronoun.secondSingular: json[Pronoun.secondSingular.jsonKey()],
    Pronoun.thirdSingular: json[Pronoun.thirdSingular.jsonKey()],
    Pronoun.firstPlural: json[Pronoun.firstPlural.jsonKey()],
    Pronoun.secondPlural: json[Pronoun.secondPlural.jsonKey()],
    Pronoun.thirdPlural: json[Pronoun.thirdPlural.jsonKey()],
  };
}
