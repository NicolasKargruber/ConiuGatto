import 'package:flutter/foundation.dart';

import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/quizzed_question.dart';
import '../../../domain/utils/language_level_extensions.dart';
import '../../view_model.dart';

typedef QuizzedTense = ({ItalianTense tense, List<QuizzedQuestion> quizzedQuestions, double progress});

class HistoryViewModel extends ViewModel {
  static final _logTag = (HistoryViewModel).toString();

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
  }

  LanguageLevel _selectedLanguageLevel = LanguageLevel.a1;
  LanguageLevel get selectedLanguageLevel => _selectedLanguageLevel;

  List<QuizzedQuestion> _quizzedQuestions = [];

  selectLanguageLevel(LanguageLevel languageLevel) {
    debugPrint("$_logTag | selectLanguageLevel($languageLevel)");
    _selectedLanguageLevel = languageLevel;
    notifyListeners();
  }

  List<QuizzedTense> get indicativeTenses {
    return ItalianTense.indicativeTenses.where(_coveredInLanguageLevel).map(_toQuizzedTense).toList();
  }

  List<QuizzedTense> get subjunctiveTenses {
    return ItalianTense.subjunctiveTenses.where(_coveredInLanguageLevel).map(_toQuizzedTense).toList();
  }

  List<QuizzedTense> get conditionalTenses {
    return ItalianTense.conditionalTenses.where(_coveredInLanguageLevel).map(_toQuizzedTense).toList();
  }

  List<QuizzedTense> get imperativeTenses {
    return ItalianTense.imperativeTenses.where(_coveredInLanguageLevel).map(_toQuizzedTense).toList();
  }

  bool _coveredInLanguageLevel(ItalianTense tense) => _selectedLanguageLevel.coveredTenses.contains(tense);

  QuizzedTense _toQuizzedTense(ItalianTense tense) {
    // QuizzedQuestions
    final quizzedQuestions = _quizzedQuestions.where((question) => question.tense == tense).toList();
    quizzedQuestions.sort((a, b) => b.date.compareTo(a.date));
    // Progress
    double progress = 0.5;
    if (quizzedQuestions.isNotEmpty) {
      final correctQuestions = quizzedQuestions.where((question) => question.wasAnsweredCorrectly);
      progress = correctQuestions.length / quizzedQuestions.length;
    }
    return (tense: tense, quizzedQuestions: quizzedQuestions, progress: progress);
  }
}
