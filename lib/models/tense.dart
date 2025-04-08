import 'package:coniugatto/models/pronoun.dart';
import 'package:coniugatto/models/verb.dart';

class Tense {
  final String name;
  final bool usesPastParticiple;
  final Conjugations conjugations;

  operator [](Pronoun pronoun) => conjugations[pronoun];

  Tense({required this.name, required this.conjugations, this.usesPastParticiple = false});

  factory Tense.fromJson(Map<String, dynamic> json, {required String name}) {
    mapToConjugations(Pronoun pronoun) {
      final verbConjugation = json[pronoun.jsonKey()];
      return Conjugation(
        pronoun,
        verbConjugation == null
            ? null
            : (italian: verbConjugation['italian'], english: verbConjugation['english']),
      );
    }
    return Tense(name: name, conjugations: Conjugations.fromEntries(Pronoun.values.map(mapToConjugations)));
  }
}