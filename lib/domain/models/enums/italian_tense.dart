
import 'mood.dart';

typedef LabeledPrefs = ({String prefKey, String label});

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
  static List<LabeledPrefs>  get indicativeLabeledPrefs => values.where((tense) => tense.mood == Mood.indicative).map((e) => (prefKey: e.prefKey, label: e.label)).toList();
  static List<LabeledPrefs>  get subjunctiveLabeledPrefs => values.where((tense) => tense.mood == Mood.subjunctive).map((e) => (prefKey: e.prefKey, label: e.label)).toList();
  static List<LabeledPrefs>  get conditionalLabeledPrefs => values.where((tense) => tense.mood == Mood.conditional).map((e) => (prefKey: e.prefKey, label: e.label)).toList();
  static List<LabeledPrefs>  get imperativeLabeledPrefs => values.where((tense) => tense.mood == Mood.imperative).map((e) => (prefKey: e.prefKey, label: e.label)).toList();
}