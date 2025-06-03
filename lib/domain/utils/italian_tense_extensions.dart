import '../../data/enums/italian_tense.dart';
import '../models/enums/language_level.dart';
import 'language_level_extensions.dart';

extension ItalianTenseExtensions on ItalianTense {
  LanguageLevel get level {
    return switch(this) {
      ItalianTense.presentIndicative => LanguageLevel.a1,
      ItalianTense.presentContinuousIndicative => LanguageLevel.a1,
      ItalianTense.imperfectIndicative => LanguageLevel.a2,
      ItalianTense.presentPerfectIndicative => LanguageLevel.a1,
      ItalianTense.pastPerfectIndicative => LanguageLevel.a2,
      ItalianTense.historicalPresentPerfectIndicative => LanguageLevel.c1,
      ItalianTense.historicalPastPerfectIndicative => LanguageLevel.c1,
      ItalianTense.futureIndicative => LanguageLevel.a1,
      ItalianTense.futurePerfectIndicative => LanguageLevel.b1,
      ItalianTense.presentSubjunctive => LanguageLevel.b1,
      ItalianTense.imperfectSubjunctive => LanguageLevel.b2,
      ItalianTense.presentPerfectSubjunctive => LanguageLevel.b1,
      ItalianTense.pastPerfectSubjunctive => LanguageLevel.b2,
      ItalianTense.presentConditional => LanguageLevel.a2,
      ItalianTense.presentPerfectConditional => LanguageLevel.b1,
      ItalianTense.positiveImperative => LanguageLevel.a1,
      ItalianTense.negativeImperative => LanguageLevel.a2
    };
  }

  static List<ItalianTense> get sortedByLevel {
    return LanguageLevel.a1.coveredTenses +
        LanguageLevel.a2.coveredTenses +
        LanguageLevel.b1.coveredTenses +
        LanguageLevel.b2.coveredTenses +
        LanguageLevel.c1.coveredTenses;

  }

  /*bool isLevel(LanguageLevel level) {
    return level == this.level;
  }*/
}