import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../data/enums/pronoun.dart';
import '../../data/repository/shared_preference_repository.dart';
import '../../data/enums/italian_tense.dart';
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

  // TODO Add more default values, make use of them
  // Verbs
  //final _reflexiveFiltersDefaultValue = ReflexiveVerb.include;
  final _verbFavouritesDefaultValue = VerbFavouriteFilter.all;
  final _irregularityFiltersDefaultValue = VerbIrregularityFilter.any;
  final _endingFiltersDefaultValue = VerbEndingFilter.all;
  // Tenses
  final _tensesDefaultValue = [ItalianTense.presentIndicative];
  // Pronoun
  final _pronounsDefaultValue = Pronoun.values.toList();

  // Verbs
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
  //loadReflexiveFiltersPref() => _loadPref(_reflexiveFiltersPrefKey);
  List<Verb> getStarredVerbsFrom(List<Verb> verbs) {
    final starredVerbPrefs = _sharedPreferenceRepo.loadStarredVerbPrefs() ?? [];
    return verbs.where((verb) => starredVerbPrefs.contains(verb.prefKey)).toList();
  }
  //loadCustomizedVerbsPrefs() => _loadPrefs(_customizedVerbsPrefKey);
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

  // Verbs
  void updateVerbFavourite(VerbFavouriteFilter favourite) =>
      _sharedPreferenceRepo.updateVerbFavouritePref(favourite.prefKey);
  void updateIrregularityFilter(VerbIrregularityFilter irregularity) =>
      _sharedPreferenceRepo.updateIrregularityFilterPref(irregularity.prefKey);
  void updateEndingFilter(VerbEndingFilter ending) =>
      _sharedPreferenceRepo.updateEndingFilterPref(ending.prefKey);
  //updateReflexiveFilterPref(String value) => _updatePref(_reflexiveFiltersPrefKey, value);
  void addStarredVerb(Verb verb) => _sharedPreferenceRepo.addStarredVerbFromPrefs(verb.prefKey);
  //updateStarredVerbPrefs(Set<String> values) => _sharedPreferenceRepo.update(_starredVerbsPrefKey, values);
  //updateCustomizedVerbsPrefs(Set<String> values) => _updatePrefs(_customizedVerbsPrefKey, values);
  // Tenses
  void updateTensePrefs(List<ItalianTense> values) =>
      _sharedPreferenceRepo.updateTensePrefs(values.map((e) => e.prefKey).toSet());
  // Pronoun
  void updatePronounPrefs(List<Pronoun> values) =>
      _sharedPreferenceRepo.updatePronounPrefs(values.map((e) => e.prefKey).toSet());

  // Removing
  void removeStarredVerb(Verb verb) => _sharedPreferenceRepo.removeStarredVerbFromPrefs(verb.prefKey);
  //removeVerbFavouritePref() => _sharedPreferenceRepo.removeVerbFavouritePref();
  //removeIrregularityFilterPref() => _sharedPreferenceRepo.removeIrregularityFilterPref();
  //removeEndingFilterPref() => _sharedPreferenceRepo.removeEndingFilterPref();
  //removeCustomizedVerbsPrefs() => _removePref(_customizedVerbsPrefKey);
}
