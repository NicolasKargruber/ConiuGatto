
import 'mood.dart';

enum ItalianTense {
  // INDICATIVE
  presentIndicative("Presente", Mood.indicative),
  presentContinuousIndicative("Presente Progressivo", Mood.indicative),
  imperfectIndicative("Imperfetto", Mood.indicative),
  presentPerfectIndicative("Passato Prossimo", Mood.indicative),
  pastPerfectIndicative("Trapassato Prossimo", Mood.indicative),
  historicalPresentPerfectIndicative("Passato Remoto", Mood.indicative),
  historicalPastPerfectIndicative("Trapassato Remoto", Mood.indicative),
  futureIndicative("Futuro", Mood.indicative),
  futurePerfectIndicative("Futuro Anteriore", Mood.indicative),
  // SUBJUNCTIVE
  presentSubjunctive("Presente", Mood.subjunctive),
  imperfectSubjunctive("Imperfetto", Mood.subjunctive),
  presentPerfectSubjunctive("Passato", Mood.subjunctive),
  pastPerfectSubjunctive("Trapassato", Mood.subjunctive),
  // CONDITIONAL
  presentConditional("Presente", Mood.conditional),
  presentPerfectConditional("Passato", Mood.conditional),
  // IMPERATIVE
  positiveImperative("Positivo", Mood.imperative),
  negativeImperative("Negativo", Mood.imperative);

  final String label;
  final Mood mood;
  const ItalianTense(this.label, this.mood);

  String get extendedLabel => "$label - ${mood.label}";
  String get prefKey => toString();
  static List<ItalianTense>  get indicativeTenses => values.where((tense) => tense.mood == Mood.indicative).toList();
  static List<ItalianTense>  get subjunctiveTenses => values.where((tense) => tense.mood == Mood.subjunctive).toList();
  static List<ItalianTense>  get conditionalTenses => values.where((tense) => tense.mood == Mood.conditional).toList();
  static List<ItalianTense>  get imperativeTenses => values.where((tense) => tense.mood == Mood.imperative).toList();
}