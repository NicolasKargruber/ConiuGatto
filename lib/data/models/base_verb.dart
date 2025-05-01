import 'tenses/conditional_tenses.dart';
import 'tenses/imperative_tenses.dart';
import 'tenses/indicative_tenses.dart';
import 'tenses/subjunctive_tenses.dart';

class BaseVerb {
  // INDICATIVE => START
  /// => Indicativo Presente
  final PresentIndicative presentIndicative;
  /// => Indicativo Imperfecto
  final ImperfectIndicative imperfectIndicative;
  /// => Indicativo Passato Remoto
  final HistoricalPresentPerfectIndicative historicalPresentPerfectIndicative;
  /// => Indicativo Futuro Semplice
  final FutureIndicative futureIndicative;
  // => Futuro Prossimo
  // TODO: => Futuro GOING TO - futuro prossimo
  // INDICATIVE <= END

  // SUBJUNCTIVE => START
  /// => Congiuntivo Presente
  final PresentSubjunctive presentSubjunctive;
  /// => Congiuntivo Imperfetto
  final ImperfectSubjunctive imperfectSubjunctive;
  // SUBJUNCTIVE <= END

  // CONDITIONAL => START
  /// Condizionale Presente
  final PresentConditional presentConditional;
  // CONDITIONAL <= END

  // IMPERATIVE => START
  /// => Imperativo Positivo
  final PositiveImperative positiveImperative;
  // IMPERATIVE <= END

  BaseVerb({
    required this.presentIndicative,
    required this.imperfectIndicative,
    required this.historicalPresentPerfectIndicative,
    required this.futureIndicative,
    required this.presentSubjunctive,
    required this.imperfectSubjunctive,
    required this.presentConditional,
    required this.positiveImperative,
  });
}