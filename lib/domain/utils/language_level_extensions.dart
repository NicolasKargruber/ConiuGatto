import '../../data/enums/italian_tense.dart';
import '../models/enums/language_level.dart';
import 'italian_tense_extensions.dart';

extension LanguageLevelExtensions on LanguageLevel {
  static List<ItalianTense> get _a1Tenses => ItalianTense.values.where((tense) => tense.level == LanguageLevel.a1).toList();
  static List<ItalianTense> get _a2Tenses => ItalianTense.values.where((tense) => tense.level == LanguageLevel.a2).toList();
  static List<ItalianTense> get _b1Tenses => ItalianTense.values.where((tense) => tense.level == LanguageLevel.b1).toList();
  static List<ItalianTense> get _b2Tenses => ItalianTense.values.where((tense) => tense.level == LanguageLevel.b2).toList();
  static List<ItalianTense> get _c1Tenses => ItalianTense.values.where((tense) => tense.level == LanguageLevel.c1).toList();

  /*List<ItalianTense> get coveredTenses {
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
  }*/

List<ItalianTense> get coveredTenses {
    return switch(this) {
      LanguageLevel.a1 => _a1Tenses,
      LanguageLevel.a2 => _a2Tenses,
      LanguageLevel.b1 => _b1Tenses,
      LanguageLevel.b2 => _b2Tenses,
      LanguageLevel.c1 => _c1Tenses
    };
  }
}