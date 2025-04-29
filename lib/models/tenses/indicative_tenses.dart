import '../verb.dart';
import 'tense.dart';

/// => Indicativo Presente
final class PresentIndicative extends Tense {
  static const String name = 'Presente';
  PresentIndicative({required super.conjugations}) : super(label: name,  extendedLabel: '$name - Indicativo', );
  
  factory PresentIndicative.fromJson(Map<String, dynamic> json) {
    return PresentIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Presente Progressivo
final class PresentContinuousIndicative extends Tense {
  static const String name = 'Presente Progressivo';
  PresentContinuousIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo', isCompound: true);
}


/// => Indicativo Imperfetto
final class ImperfectIndicative extends Tense {
  static const String name = 'Imperfetto';
  ImperfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',);

  factory ImperfectIndicative.fromJson(Map<String, dynamic> json) {
    return ImperfectIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Passato Prossimo
final class PresentPerfectIndicative extends Tense {
  static const String name = 'Passato Prossimo';
  PresentPerfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Trapassato Prossimo
final class PastPerfectIndicative extends Tense {
  static const String name = 'Trapassato Prossimo';
  PastPerfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Passato Remoto
final class HistoricalPresentPerfectIndicative extends Tense {
  static const String name = 'Passato Remoto';
  HistoricalPresentPerfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',);

  factory HistoricalPresentPerfectIndicative.fromJson(Map<String, dynamic> json) {
    return HistoricalPresentPerfectIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Trapassato Remoto
final class HistoricalPastPerfectIndicative extends Tense {
  static const String name = 'Trapassato Remoto';
  HistoricalPastPerfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',isCompound: true, usesPastParticiple: true);
}

/// => Indicativo Futuro
final class FutureIndicative extends Tense {
  static const String name = 'Futuro';
  FutureIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo',);

  factory FutureIndicative.fromJson(Map<String, dynamic> json) {
    return FutureIndicative(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Indicativo Futuro Anteriore
final class FuturePerfectIndicative extends Tense {
  static const String name = 'Futuro Anteriore';
  FuturePerfectIndicative({required super.conjugations}) : super(label: name, extendedLabel: '$name - Indicativo', isCompound: true, usesPastParticiple: true);
}

