import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/quizzed_question.dart';
import '../../../domain/service/history_service.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/language_level_extensions.dart';
import '../../../domain/utils/quizzed_question_extensions.dart';
import '../../view_model.dart';

typedef QuizzedTense = ({ItalianTense type, String daysAgoLabel, double fluency, double milestone});
typedef QuizzedLanguageLevel = ({List<QuizzedTense> quizzedTenses, LanguageLevel type, double progress});

class TensesViewModel extends ViewModel {
  static final _logTag = (TensesViewModel).toString();

  final SharedPreferenceService _preferenceService;
  final HistoryService _historyService;

  TensesViewModel(this._preferenceService, this._historyService);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await _preferenceService.initializationFuture;
    await _historyService.initializationFuture;
    _selectedLanguageLevel = _preferenceService.loadLanguageLevel();
  }

  List<QuizzedQuestion> _quizzedQuestions = [];

  updateHistory(List<QuizzedQuestion> quizzedQuestions) {
    debugPrint("$_logTag | updateHistory()");

    if (UnorderedIterableEquality().equals(_quizzedQuestions, quizzedQuestions)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }

    _quizzedQuestions = quizzedQuestions;
    notifyListeners();
  }

  // TODO: Move to Shared Preference
  final fluencyMilestone = 0.75;

  LanguageLevel? _selectedLanguageLevel;

  LanguageLevel? get selectedLanguageLevel => _selectedLanguageLevel;

  selectLanguageLevel(LanguageLevel languageLevel) {
    debugPrint("$_logTag | selectLanguageLevel($languageLevel)");
    _selectedLanguageLevel = languageLevel;
    _preferenceService.updateLanguageLevel(languageLevel);
    notifyListeners();
  }

  QuizzedLanguageLevel get quizzedLevelA1 {
    final quizzedTenses = LanguageLevelExtensions.a1Tenses.map(_toQuizzedTense).toList();
    final fluentTenses = quizzedTenses.where((tense) => tense.fluency >= fluencyMilestone);
    return (type: LanguageLevel.a1, quizzedTenses: quizzedTenses, progress: fluentTenses.length / quizzedTenses.length);
  }

  QuizzedLanguageLevel get quizzedLevelA2 {
    final quizzedTenses = LanguageLevelExtensions.a2Tenses.map(_toQuizzedTense).toList();
    final fluentTenses = quizzedTenses.where((tense) => tense.fluency >= fluencyMilestone);
    return (type: LanguageLevel.a2, quizzedTenses: quizzedTenses, progress: fluentTenses.length / quizzedTenses.length);
  }

  QuizzedLanguageLevel get quizzedLevelB1 {
    final quizzedTenses = LanguageLevelExtensions.b1Tenses.map(_toQuizzedTense).toList();
    final fluentTenses = quizzedTenses.where((tense) => tense.fluency >= fluencyMilestone);
    return (type: LanguageLevel.b1, quizzedTenses: quizzedTenses, progress: fluentTenses.length / quizzedTenses.length);
  }

  QuizzedLanguageLevel get quizzedLevelB2 {
    final quizzedTenses = LanguageLevelExtensions.b2Tenses.map(_toQuizzedTense).toList();
    final fluentTenses = quizzedTenses.where((tense) => tense.fluency >= fluencyMilestone);
    return (type: LanguageLevel.b2, quizzedTenses: quizzedTenses, progress: fluentTenses.length / quizzedTenses.length);
  }

  QuizzedLanguageLevel get quizzedLevelC1 {
    final quizzedTenses = LanguageLevelExtensions.c1Tenses.map(_toQuizzedTense).toList();
    final fluentTenses = quizzedTenses.where((tense) => tense.fluency >= fluencyMilestone);
    return (type: LanguageLevel.c1, quizzedTenses: quizzedTenses, progress: fluentTenses.length / quizzedTenses.length);
  }

  QuizzedTense _toQuizzedTense(ItalianTense tense) {
    // QuizzedQuestions - Last 100
    var quizzedQuestions = _quizzedQuestions.where((question) => question.tense == tense).toList();
    quizzedQuestions.sort((a, b) => b.date.compareTo(a.date));
    quizzedQuestions = quizzedQuestions.take(100).toList();
    // Progress
    double fluency = 0.5;
    if (quizzedQuestions.isNotEmpty) {
      final correctQuestions = quizzedQuestions.where((question) => question.correct);
      fluency = correctQuestions.length / quizzedQuestions.length;
      if (quizzedQuestions.length < 100) {
        final weight = ((100 - quizzedQuestions.length) / 100);
        fluency = fluency + weight * (0.5 - fluency);
      }
    }
    return (type: tense, daysAgoLabel: quizzedQuestions.daysAgoLabel, fluency: fluency, milestone: fluencyMilestone);
  }
}
