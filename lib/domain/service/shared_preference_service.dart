import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../data/enums/pronoun.dart';
import '../../data/repository/shared_preference_repository.dart';
import '../../data/enums/italian_tense.dart';
import '../models/enums/auxiliary_filter.dart';
import '../models/enums/language_level.dart';
import '../models/enums/verb_ending_filter.dart';
import '../models/enums/verb_favourite_filter.dart';
import '../models/enums/verb_irregularity_filter.dart';
import '../models/verb.dart';
import 'service.dart';


// TODO Move using GetIt
class SharedPreferenceService extends Service {
  static final _logTag = (SharedPreferenceService).toString();

  late final SharedPreferenceRepository _sharedPreferenceRepo;

  SharedPreferenceService();

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _sharedPreferenceRepo = await SharedPreferenceRepository.initialize();
  }

  // Verbs
  final _verbFavouritesDefaultValue = VerbFavouriteFilter.top25;
  final _irregularityFiltersDefaultValue = VerbIrregularityFilter.any;
  final _endingFiltersDefaultValue = VerbEndingFilter.all;
  final _auxiliaryFiltersDefaultValue = AuxiliaryFilter.any;
  // Tenses
  final _tensesDefaultValue = [ItalianTense.presentIndicative];
  // Pronoun
  final _pronounsDefaultValue = Pronoun.values.toList();
  // Language Level
  final _languageLevelDefaultValue = LanguageLevel.a1;

  // Introduction
  final _skipIntroductionDefaultValue = false;
  bool loadSkipIntroductionPref() => _sharedPreferenceRepo.loadSkipIntroductionPref() ?? _skipIntroductionDefaultValue;
  void setSkipIntroductionPrefToTrue() => _sharedPreferenceRepo.updateSkipIntroductionPref(true);

  // InAppReview
  final _launchCountDefaultValue = 0;
  int loadLaunchCount() => _sharedPreferenceRepo.loadLaunchCount() ?? _launchCountDefaultValue;
  void updateLaunchCount(int value) => _sharedPreferenceRepo.updateLaunchCount(value);

  // Verbs
  List<Verb> getStarredVerbsFrom(List<Verb> verbs) {
    final starredVerbPrefs = _sharedPreferenceRepo.loadStarredVerbPrefs() ?? [];
    return verbs.where((verb) => starredVerbPrefs.contains(verb.prefKey)).toList();
  }
  VerbFavouriteFilter loadVerbFavouriteFilter() {
    return VerbFavouriteFilter.values.firstWhereOrNull((e) =>
    e.prefKey == _sharedPreferenceRepo.loadVerbFavouritePref()) ?? _verbFavouritesDefaultValue;
  }
  VerbIrregularityFilter loadVerbIrregularityFilter() {
    return VerbIrregularityFilter.values.firstWhereOrNull((e) =>
    e.prefKey == _sharedPreferenceRepo.loadIrregularityFilterPref()) ?? _irregularityFiltersDefaultValue;
  }
  VerbEndingFilter loadVerbEndingFilter() {
    return VerbEndingFilter.values.firstWhereOrNull((e) =>
    e.prefKey == _sharedPreferenceRepo.loadEndingFilterPref()) ?? _endingFiltersDefaultValue;
  }
  AuxiliaryFilter loadAuxiliaryFilter() {
    return AuxiliaryFilter.values.firstWhereOrNull((e) =>
    e.prefKey == _sharedPreferenceRepo.loadAuxiliaryFilterPref()) ?? _auxiliaryFiltersDefaultValue;
  }
  // Tenses
  List<ItalianTense> loadTenses() {
    final List<String>? prefs = _sharedPreferenceRepo.loadTensePrefs();
    return prefs?.map((e) => ItalianTense.values.firstWhere((tense) => tense.prefKey == e)).toList() ??
        _tensesDefaultValue;
  }
  // Pronoun
  List<Pronoun> loadPronouns() {
    final List<String>? prefs = _sharedPreferenceRepo.loadPronounPrefs();
    return prefs?.map((e) => Pronoun.values.firstWhere((pronoun) => pronoun.prefKey == e)).toList() ??
        _pronounsDefaultValue;
  }
  // Language Level
  LanguageLevel loadLanguageLevel() {
    return LanguageLevel.values.firstWhereOrNull((e) =>
    e.prefKey == _sharedPreferenceRepo.loadLanguageLevelPref()) ?? _languageLevelDefaultValue;
  }

  // Verbs
  void addStarredVerb(Verb verb) => _sharedPreferenceRepo.addStarredVerbFromPrefs(verb.prefKey);
  void updateVerbFavourite(VerbFavouriteFilter favourite) =>
      _sharedPreferenceRepo.updateVerbFavouritePref(favourite.prefKey);
  void updateIrregularityFilter(VerbIrregularityFilter irregularity) =>
      _sharedPreferenceRepo.updateIrregularityFilterPref(irregularity.prefKey);
  void updateEndingFilter(VerbEndingFilter ending) =>
      _sharedPreferenceRepo.updateEndingFilterPref(ending.prefKey);
  void updateAuxiliaryFilter(AuxiliaryFilter auxiliary) =>
      _sharedPreferenceRepo.updateAuxiliaryFilterPref(auxiliary.prefKey);
  // Tenses
  void updateTensePrefs(List<ItalianTense> values) =>
      _sharedPreferenceRepo.updateTensePrefs(values.map((e) => e.prefKey).toSet());
  // Pronoun
  void updatePronounPrefs(List<Pronoun> values) =>
      _sharedPreferenceRepo.updatePronounPrefs(values.map((e) => e.prefKey).toSet());
  // Language Level
  void updateLanguageLevel(LanguageLevel languageLevel) =>
      _sharedPreferenceRepo.updateLanguageLevelPref(languageLevel.prefKey);

  // Removing
  void removeStarredVerb(Verb verb) => _sharedPreferenceRepo.removeStarredVerbFromPrefs(verb.prefKey);

  // Localization
  Locale? get locale {
    try {
      return Locale(_sharedPreferenceRepo.loadLocale()!);
    } catch (_) {
      return null;
    }
  }
  set locale(Locale? locale) => _sharedPreferenceRepo.updateLocale(locale?.languageCode ?? '');
}
