import '../models/enums/italian_tense.dart';
import '../models/enums/language_level.dart';

extension LanguageLevelExtensions on LanguageLevel {
  static const a1Tenses = [
    ItalianTense.presentIndicative,
    ItalianTense.presentPerfectIndicative,
    ItalianTense.futureIndicative,
    ItalianTense.positiveImperative,
  ];

  static const a2Tenses = [
    ItalianTense.imperfectIndicative,
    ItalianTense.pastPerfectIndicative,
    ItalianTense.presentConditional,
    ItalianTense.negativeImperative,
  ];

  static const b1Tenses = [
    ItalianTense.futurePerfectIndicative,
    ItalianTense.presentSubjunctive,
    ItalianTense.presentPerfectSubjunctive,
    ItalianTense.presentPerfectConditional,
  ];

  static const b2Tenses = [
    ItalianTense.imperfectSubjunctive,
    ItalianTense.pastPerfectSubjunctive,
  ];

  static const c1Tenses = [
    ItalianTense.historicalPresentPerfectIndicative,
    ItalianTense.historicalPastPerfectIndicative,
  ];

  List<ItalianTense> get coveredTenses {
    switch(this) {
      case LanguageLevel.a1:
        return a1Tenses;
      case LanguageLevel.a2:
        return a1Tenses + a2Tenses;
      case LanguageLevel.b1:
        return a1Tenses + a2Tenses + b1Tenses;
      case LanguageLevel.b2:
        return a1Tenses + a2Tenses + b1Tenses + b2Tenses;
      case LanguageLevel.c1:
        return a1Tenses + a2Tenses + b1Tenses + b2Tenses + c1Tenses;
    }
  }
}