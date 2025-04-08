import '../verb.dart';
import 'tense.dart';

/// => Indicativo Presente
final class PresentIndicative extends Tense {
  PresentIndicative({required super.conjugations}) : super(label: 'Presente');
  
  factory PresentIndicative.fromJson(Map<String, dynamic> json) {
    return PresentIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Presente Progressivo
final class PresentContinuousIndicative extends Tense {
  PresentContinuousIndicative({required super.conjugations}) : super(label: 'Presente Progressivo', isCompound: true);
}


/// => Indicativo Imperfetto
final class ImperfectIndicative extends Tense {
  ImperfectIndicative({required super.conjugations}) : super(label: 'Imperfetto');

  factory ImperfectIndicative.fromJson(Map<String, dynamic> json) {
    return ImperfectIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Passato Prossimo
final class PresentPerfectIndicative extends Tense {
  PresentPerfectIndicative({required super.conjugations}) : super(label: 'Passato Prossimo', isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Trapassato Prossimo
final class PastPerfectIndicative extends Tense {
  PastPerfectIndicative({required super.conjugations}) : super(label: 'Trapassato Prossimo', isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Passato Remoto
final class HistoricalPresentPerfectIndicative extends Tense {
  HistoricalPresentPerfectIndicative({required super.conjugations}) : super(label: 'Passato Remoto');

  factory HistoricalPresentPerfectIndicative.fromJson(Map<String, dynamic> json) {
    return HistoricalPresentPerfectIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Trapassato Remoto
final class HistoricalPastPerfectIndicative extends Tense {
  HistoricalPastPerfectIndicative({required super.conjugations}) : super(label: 'Trapassato Remoto', isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Futuro
final class FutureIndicative extends Tense {
  FutureIndicative({required super.conjugations}) : super(label: 'Futuro');

  factory FutureIndicative.fromJson(Map<String, dynamic> json) {
    return FutureIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Futuro Anteriore
final class FuturePerfectIndicative extends Tense {
  FuturePerfectIndicative({required super.conjugations}) : super(label: 'Futuro Anteriore', isCompound: true, usesPastParticiple: true);
}

