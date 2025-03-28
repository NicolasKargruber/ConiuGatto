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
  // final Conjugation futuro anteriore; // Futuro Perfect

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

Map<Pronoun, String> parseConjugations(Map<String, dynamic> json) {
  return {
    Pronoun.io: json['io'],
    Pronoun.tu: json['tu'],
    Pronoun.luiLei: json['lui/lei'],
    Pronoun.noi: json['noi'],
    Pronoun.voi: json['voi'],
    Pronoun.loro: json['loro'],
  };
}
