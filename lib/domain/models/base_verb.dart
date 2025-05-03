import 'tenses/tense.dart';

class BaseVerb {
  // INDICATIVE => START
  /// => Indicativo Presente
  final Tense presentIndicative;
  /// => Indicativo Imperfecto
  final Tense imperfectIndicative;
  /// => Indicativo Passato Remoto
  final Tense historicalPresentPerfectIndicative;
  /// => Indicativo Futuro Semplice
  final Tense futureIndicative;
  // => Futuro Prossimo
  // TODO: => Futuro GOING TO - futuro prossimo
  // INDICATIVE <= END

  // SUBJUNCTIVE => START
  /// => Congiuntivo Presente
  final Tense presentSubjunctive;
  /// => Congiuntivo Imperfetto
  final Tense imperfectSubjunctive;
  // SUBJUNCTIVE <= END

  // CONDITIONAL => START
  /// Condizionale Presente
  final Tense presentConditional;
  // CONDITIONAL <= END

  BaseVerb({
    required this.presentIndicative,
    required this.imperfectIndicative,
    required this.historicalPresentPerfectIndicative,
    required this.futureIndicative,
    required this.presentSubjunctive,
    required this.imperfectSubjunctive,
    required this.presentConditional,
  });
}