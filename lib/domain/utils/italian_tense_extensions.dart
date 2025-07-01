import 'package:flutter/cupertino.dart';

import '../../data/enums/italian_tense.dart';
import '../../utilities/extensions/build_context_extensions.dart';
import '../models/enums/language_level.dart';
import 'language_level_extensions.dart';

extension ItalianTenseExtensions on ItalianTense {
  LanguageLevel get level {
    return switch(this) {
      ItalianTense.presentIndicative => LanguageLevel.a1,
      ItalianTense.presentContinuousIndicative => LanguageLevel.b1,
      ItalianTense.imperfectIndicative => LanguageLevel.a1,
      ItalianTense.presentPerfectIndicative => LanguageLevel.a1,
      ItalianTense.pastPerfectIndicative => LanguageLevel.b1,
      ItalianTense.historicalPresentPerfectIndicative => LanguageLevel.c1,
      ItalianTense.historicalPastPerfectIndicative => LanguageLevel.c1,
      ItalianTense.futureIndicative => LanguageLevel.a2,
      ItalianTense.futurePerfectIndicative => LanguageLevel.b1,
      ItalianTense.presentSubjunctive => LanguageLevel.b2,
      ItalianTense.imperfectSubjunctive => LanguageLevel.c1,
      ItalianTense.presentPerfectSubjunctive => LanguageLevel.b2,
      ItalianTense.pastPerfectSubjunctive => LanguageLevel.c1,
      ItalianTense.presentConditional => LanguageLevel.a2,
      ItalianTense.presentPerfectConditional => LanguageLevel.b1,
      ItalianTense.positiveImperative => LanguageLevel.a2,
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

  String get example {
    return switch(this) {
      ItalianTense.presentIndicative => "io lavo",
      ItalianTense.presentContinuousIndicative => "io sto lavando",
      ItalianTense.imperfectIndicative => "io lavavo",
      ItalianTense.presentPerfectIndicative => "io ho lavato",
      ItalianTense.pastPerfectIndicative => "io avevo lavato",
      ItalianTense.historicalPresentPerfectIndicative => "io lavai",
      ItalianTense.historicalPastPerfectIndicative => "io ebbi lavato",
      ItalianTense.futureIndicative => "io laveró",
      ItalianTense.futurePerfectIndicative => "io avrò lavato",
      ItalianTense.presentSubjunctive => "io lavi",
      ItalianTense.imperfectSubjunctive => "io lavassi",
      ItalianTense.presentPerfectSubjunctive => "io abbia lavato",
      ItalianTense.pastPerfectSubjunctive => "io avessi lavato",
      ItalianTense.presentConditional => "io laverei",
      ItalianTense.presentPerfectConditional => "io avrei lavato",
      ItalianTense.positiveImperative => "lava!",
      ItalianTense.negativeImperative => "non lavare!"
    };
  }

  String getExampleTranslation(BuildContext context) {
    return switch(context.localization.localeName) {
      "en" => _exampleTranslationEnglish,
      "de" => _exampleTranslationGerman,
        _ => _exampleTranslationEnglish
    };
  }

  String get _exampleTranslationEnglish {
    return switch(this) {
      ItalianTense.presentIndicative => "I  wash",
      ItalianTense.presentContinuousIndicative => "I  am washing",
      ItalianTense.imperfectIndicative => "I  used to wash",
      ItalianTense.presentPerfectIndicative => "I  have washed",
      ItalianTense.pastPerfectIndicative => "I  had washed",
      ItalianTense.historicalPresentPerfectIndicative => "I washed",
      ItalianTense.historicalPastPerfectIndicative => "I had washed",
      ItalianTense.futureIndicative => "I will wash",
      ItalianTense.futurePerfectIndicative => "I will have washed",
      ItalianTense.presentSubjunctive => "I wash",
      ItalianTense.imperfectSubjunctive => "I washed",
      ItalianTense.presentPerfectSubjunctive => "I washed",
      ItalianTense.pastPerfectSubjunctive => "I had washed",
      ItalianTense.presentConditional => "I would wash",
      ItalianTense.presentPerfectConditional => "I would have washed",
      ItalianTense.positiveImperative => "wash!",
      ItalianTense.negativeImperative => "don't wash!"
    };
  }

  String get _exampleTranslationGerman {
    return switch(this) {
      ItalianTense.presentIndicative => "Ich wasche",
      ItalianTense.presentContinuousIndicative => "Ich wasche gerade",
      ItalianTense.imperfectIndicative => "Ich wusch",
      ItalianTense.presentPerfectIndicative => "Ich habe gewaschen",
      ItalianTense.pastPerfectIndicative => "Ich hatte gewaschen",
      ItalianTense.historicalPresentPerfectIndicative => "Ich wusch",
      ItalianTense.historicalPastPerfectIndicative => "Ich hatte gewaschen",
      ItalianTense.futureIndicative => "Ich werde waschen",
      ItalianTense.futurePerfectIndicative => "Ich werde gewaschen haben",
      ItalianTense.presentSubjunctive => "Ich wasche",
      ItalianTense.imperfectSubjunctive => "Ich waschte",
      ItalianTense.presentPerfectSubjunctive => "Ich habe gewaschen",
      ItalianTense.pastPerfectSubjunctive => "Ich hatte gewaschen",
      ItalianTense.presentConditional => "Ich würde waschen",
      ItalianTense.presentPerfectConditional => "Ich würde gewaschen haben",
      ItalianTense.positiveImperative => "wasch!",
      ItalianTense.negativeImperative => "wasch nicht!"
    };
  }
}