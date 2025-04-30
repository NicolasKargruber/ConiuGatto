import 'italian_tense.dart';
import 'tense.dart';

/// => Congiuntivo Presente
final class PresentSubjunctive extends Tense {
  static const String jsonKey = 'presente';
  PresentSubjunctive({required super.conjugations}) : super(type: ItalianTense.presentSubjunctive);

  factory PresentSubjunctive.fromJson(Map<String, dynamic> json) {
    return PresentSubjunctive(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Congiuntivo Imperfetto
final class ImperfectSubjunctive extends Tense {
  static const String jsonKey = 'imperfetto';
  ImperfectSubjunctive({required super.conjugations}) : super(type: ItalianTense.imperfectSubjunctive);

  factory ImperfectSubjunctive.fromJson(Map<String, dynamic> json) {
    return ImperfectSubjunctive(conjugations: Tense.convertJsonToConjugations(json[jsonKey]));
  }
}

/// => Congiuntivo Passato
final class PresentPerfectSubjunctive extends Tense {
  PresentPerfectSubjunctive({required super.conjugations}) : super(type: ItalianTense.presentPerfectSubjunctive, isCompound: true, usesPastParticiple: true);
}

/// => Congiuntivo Trapassato
final class PastPerfectSubjunctive extends Tense {
  PastPerfectSubjunctive({required super.conjugations}) : super(type: ItalianTense.pastPerfectSubjunctive, isCompound: true, usesPastParticiple: true);
}