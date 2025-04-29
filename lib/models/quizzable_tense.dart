import 'auxiliary.dart';
import 'moods/mood.dart';
import 'pronoun.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class QuizItem {
  Verb verb;
  Auxiliary auxiliary;
  Pronoun pronoun;
  Tense tense;

  QuizItem({
    required this.verb,
    required this.auxiliary,
    required this.tense,
    required this.pronoun
  });

  String get currentTitle => tense.extendedLabel;
  bool get hasConjugations => tense.conjugations.values.any((conjugatedVerb) => conjugatedVerb != null);

  String? get solution => tense[pronoun]?.italian;
  String? get question => "${pronoun.italian} (${verb.italianInfinitive})";
  String? get translation => "${pronoun.english} ${tense[pronoun]?.english}";
}