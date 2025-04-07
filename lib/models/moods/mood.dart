import '../pronoun.dart';
import '../verb.dart';

class Mood {}

extension MoodExtensions on Mood {
  static Conjugations parseConjugations(Map<String, dynamic> json) {
    return {
      Pronoun.firstSingular: json[Pronoun.firstSingular.jsonKey()],
      Pronoun.secondSingular: json[Pronoun.secondSingular.jsonKey()],
      Pronoun.thirdSingular: json[Pronoun.thirdSingular.jsonKey()],
      Pronoun.firstPlural: json[Pronoun.firstPlural.jsonKey()],
      Pronoun.secondPlural: json[Pronoun.secondPlural.jsonKey()],
      Pronoun.thirdPlural: json[Pronoun.thirdPlural.jsonKey()],
    };
  }
}