import 'auxiliary.dart';
import 'moods/mood.dart';
import 'pronoun.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class QuizzableTense {
  // Quiz Values
  Verb verb;
  Auxiliary auxiliary;
  Mood mood;
  Tense tense;

  String get currentPref => "${mood.label}-${tense.label}";
  String get currentTitle => "${tense.label} - ${mood.label}";
  bool get hasConjugatedVerbs => tense.conjugations.values.any((conjugatedVerb) => conjugatedVerb != null);

  String? solution(Pronoun pronoun) => tense[pronoun]?.italian;
  String? question(Pronoun pronoun) => "${pronoun.italian} (${verb.infinitive})";
  String? translation(Pronoun pronoun) => "${pronoun.english} ${tense[pronoun]?.english}";

  QuizzableTense({
    required this.verb,
    required this.auxiliary,
    required this.mood,
    required this.tense
  });
}