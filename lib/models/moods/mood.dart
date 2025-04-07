import '../pronoun.dart';
import '../verb.dart';

class Mood {}

extension MoodExtensions on Mood {
  static Conjugations parseConjugations(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) {
      final verbConjugation = json[pronoun.jsonKey()];
      return Conjugation(
        pronoun,
        verbConjugation == null
            ? null
            : (italian: verbConjugation['italian'], english: verbConjugation['english']),
      );
    }

    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }
}
