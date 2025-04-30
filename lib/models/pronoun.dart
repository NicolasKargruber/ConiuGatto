import '../utilities/extensions/string_extensions.dart';

enum Pronoun {
  firstSingular('io', 'I', 'mi'),
  secondSingular('tu', 'you', 'ti'),
  thirdSingular('lui/lei', 'he/she', 'si'),
  firstPlural('noi', 'we', 'ci'),
  secondPlural('voi', 'you all', 'vi'),
  thirdPlural('loro', 'they', 'si');

  bool get isPlural => this == Pronoun.firstPlural || this == Pronoun.secondPlural || this == Pronoun.thirdPlural;

  bool _canBeGendered(String italianParticiple) {
    if (isPlural) {
      return ['i', 'e'].contains(italianParticiple.last);
    } else {
      return ['o', 'a'].contains(italianParticiple.last);
    }
  }

  String genderItalianConjugationIfPossible(String italianParticiple, {bool forceGender = false}) {
    if (forceGender || _canBeGendered(italianParticiple)) {
      return isPlural ?
      italianParticiple.replaceLastWith('i/e') : italianParticiple.replaceLastWith('o/a');
    } else {
      return italianParticiple;
    }
  }

  String get prefKey => jsonKey;
  String get jsonKey  => italian; // => "io"
  final String italian; // => "io"
  final String english; // => "I"
  final String reflexivePronoun; // => "mi"

  const Pronoun(this.italian, this.english, this.reflexivePronoun);
}