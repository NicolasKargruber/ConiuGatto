import '../../domain/models/enums/mood.dart';

enum ItalianTense {
  // INDICATIVE
  /// Presente Indicativo
  presentIndicative("Presente", Mood.indicative),
  /// Presente Progressivo Indicativo
  presentContinuousIndicative("Presente Progressivo", Mood.indicative),
  /// Imperfetto Indicativo
  imperfectIndicative("Imperfetto", Mood.indicative),
  /// Passato Prossimo Indicativo
  presentPerfectIndicative("Passato Prossimo", Mood.indicative),
  /// Trapassato Prossimo Indicativo
  pastPerfectIndicative("Trapassato Prossimo", Mood.indicative),
  /// Passato Remoto Indicativo
  historicalPresentPerfectIndicative("Passato Remoto", Mood.indicative),
  /// Trapassato Remoto Indicativo
  historicalPastPerfectIndicative("Trapassato Remoto", Mood.indicative),
  /// Futuro Semplice Indicativo
  futureIndicative("Futuro", Mood.indicative),
  /// Futuro Anteriore Indicativo
  futurePerfectIndicative("Futuro Anteriore", Mood.indicative),
  // SUBJUNCTIVE
  /// Presente Congiuntivo
  presentSubjunctive("Presente", Mood.subjunctive),
  /// Imperfetto Congiuntivo
  imperfectSubjunctive("Imperfetto", Mood.subjunctive),
  /// Passato Congiuntivo
  presentPerfectSubjunctive("Passato", Mood.subjunctive),
  /// Trapassato Congiuntivo
  pastPerfectSubjunctive("Trapassato", Mood.subjunctive),
  // CONDITIONAL
  /// Presente Congiuntivo
  presentConditional("Presente", Mood.conditional),
  /// Passato Congiuntivo
  presentPerfectConditional("Passato", Mood.conditional),
  // IMPERATIVE
  /// Positivo Imperativo
  positiveImperative("Positivo", Mood.imperative),
  /// Negativo Imperativo
  negativeImperative("Negativo", Mood.imperative);

  final String label;
  final Mood mood;
  const ItalianTense(this.label, this.mood);

  String get extendedLabel => "$label - ${mood.label}";
  String get jsonKey => toString();
  String get prefKey => toString();
  static List<ItalianTense> get indicativeTenses => values.where((tense) => tense.mood == Mood.indicative).toList();
  static List<ItalianTense> get subjunctiveTenses => values.where((tense) => tense.mood == Mood.subjunctive).toList();
  static List<ItalianTense> get conditionalTenses => values.where((tense) => tense.mood == Mood.conditional).toList();
  static List<ItalianTense> get imperativeTenses => values.where((tense) => tense.mood == Mood.imperative).toList();

  factory ItalianTense.fromJson(dynamic json) => ItalianTense.values.firstWhere((e) => e.jsonKey == json);
}