import '../../data/enums/italian_tense.dart';
import '../models/enums/mood.dart';

extension MoodExtensions on Mood {
  List<ItalianTense> get tenses {
    return switch(this) {
      Mood.indicative => ItalianTense.indicativeTenses,
      Mood.subjunctive => ItalianTense.subjunctiveTenses,
      Mood.conditional => ItalianTense.conditionalTenses,
      Mood.imperative => ItalianTense.imperativeTenses
    };
  }
}