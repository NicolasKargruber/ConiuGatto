import 'tense.dart';

/// => Congiuntivo Presente
final class PresentSubjunctive extends Tense {
  PresentSubjunctive({required super.conjugations}) : super(label: 'Presente');

  factory PresentSubjunctive.fromJson(Map<String, dynamic> json) {
    return PresentSubjunctive(conjugations: Tense.convertJsonToConjugations(json));
  }
}

/// => Congiuntivo Passato
final class PresentPerfectSubjunctive extends Tense {
  PresentPerfectSubjunctive({required super.conjugations}) : super(label: 'Passato', isCompound: true, usesPastParticiple: true);
}

/// => Congiuntivo Trapassato
final class PastPerfectSubjunctive extends Tense {
  PastPerfectSubjunctive({required super.conjugations}) : super(label: 'Trapassato', isCompound: true, usesPastParticiple: true);
}

/// => Congiuntivo Imperfetto
final class ImperfectSubjunctive extends Tense {
  ImperfectSubjunctive({required super.conjugations}) : super(label: 'Imperfetto');

  factory ImperfectSubjunctive.fromJson(Map<String, dynamic> json) {
    return ImperfectSubjunctive(conjugations: Tense.convertJsonToConjugations(json));
  }
}