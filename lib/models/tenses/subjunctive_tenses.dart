import 'tense.dart';

/// => Congiuntivo Presente
final class PresentSubjunctive extends Tense {
  static const String name = 'Presente';
  PresentSubjunctive({required super.conjugations}) : super(label: name);

  factory PresentSubjunctive.fromJson(Map<String, dynamic> json) {
    return PresentSubjunctive(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Congiuntivo Passato
final class PresentPerfectSubjunctive extends Tense {
  static const String name = 'Passato';
  PresentPerfectSubjunctive({required super.conjugations}) : super(label: name, isCompound: true, usesPastParticiple: true);
}

/// => Congiuntivo Trapassato
final class PastPerfectSubjunctive extends Tense {
  static const String name = 'Trapassato';
  PastPerfectSubjunctive({required super.conjugations}) : super(label: name, isCompound: true, usesPastParticiple: true);
}

/// => Congiuntivo Imperfetto
final class ImperfectSubjunctive extends Tense {
  static const String name = 'Imperfetto';
  ImperfectSubjunctive({required super.conjugations}) : super(label: name);

  factory ImperfectSubjunctive.fromJson(Map<String, dynamic> json) {
    return ImperfectSubjunctive(conjugations: Tense.convertJsonToConjugations(json));
  }
}