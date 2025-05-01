import '../../enums/italian_tense.dart';
import 'tense.dart';

/// => Indicativo Presente
final class PresentIndicative extends Tense {
  static const String jsonKey = 'presente';
  PresentIndicative({required super.conjugations}) : super(type: ItalianTense.presentIndicative);
  
  factory PresentIndicative.fromJson(Map<String, dynamic> json) {
    return PresentIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Indicativo Presente Progressivo
final class PresentContinuousIndicative extends Tense {
  PresentContinuousIndicative({required super.conjugations}) : super(type: ItalianTense.presentContinuousIndicative, isCompound: true, );
}


/// => Indicativo Imperfetto
final class ImperfectIndicative extends Tense {
  static const String jsonKey = 'imperfetto';
  ImperfectIndicative({required super.conjugations}) : super(type: ItalianTense.imperfectIndicative);

  factory ImperfectIndicative.fromJson(Map<String, dynamic> json) {
    return ImperfectIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Indicativo Passato Prossimo
final class PresentPerfectIndicative extends Tense {
  PresentPerfectIndicative({required super.conjugations}) : super(type: ItalianTense.presentPerfectIndicative, isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Trapassato Prossimo
final class PastPerfectIndicative extends Tense {
  PastPerfectIndicative({required super.conjugations}) : super(type: ItalianTense.pastPerfectIndicative, isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Passato Remoto
final class HistoricalPresentPerfectIndicative extends Tense {
  static const String jsonKey = "passato_remoto";
  HistoricalPresentPerfectIndicative({required super.conjugations}) : super(type: ItalianTense.historicalPresentPerfectIndicative);

  factory HistoricalPresentPerfectIndicative.fromJson(Map<String, dynamic> json) {
    return HistoricalPresentPerfectIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Indicativo Trapassato Remoto
final class HistoricalPastPerfectIndicative extends Tense {
  HistoricalPastPerfectIndicative({required super.conjugations}) : super(type: ItalianTense.historicalPastPerfectIndicative, isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Futuro
final class FutureIndicative extends Tense {
  static const String jsonKey = 'futuro_semplice';
  FutureIndicative({required super.conjugations}) : super(type: ItalianTense.futureIndicative);

  factory FutureIndicative.fromJson(Map<String, dynamic> json) {
    return FutureIndicative(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Indicativo Futuro Anteriore
final class FuturePerfectIndicative extends Tense {
  FuturePerfectIndicative({required super.conjugations}) : super(type: ItalianTense.futurePerfectIndicative, isCompound: true, usesPastParticiple: true);
}

