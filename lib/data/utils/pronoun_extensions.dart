import '../../utilities/extensions/string_extensions.dart';
import '../enums/pronoun.dart';

extension PronounExtensions on Pronoun {
  String get english => switch(this) {
    Pronoun.firstSingular => "I",
    Pronoun.secondSingular => "you",
    Pronoun.thirdSingular => "he/she",
    Pronoun.firstPlural => "we",
    Pronoun.secondPlural => "you all",
    Pronoun.thirdPlural => "they",
  };

  String get german => switch(this) {
    Pronoun.firstSingular => "ich",
    Pronoun.secondSingular => "du",
    Pronoun.thirdSingular => "er/sie",
    Pronoun.firstPlural => "wir",
    Pronoun.secondPlural => "ihr",
    Pronoun.thirdPlural => "sie",
  };

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
}