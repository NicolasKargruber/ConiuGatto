import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/auxiliary_filter.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/enums/verb_irregularity_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../view_model.dart';

class SettingsViewModel extends ViewModel {
  static final _logTag = (SettingsViewModel).toString();

  final SharedPreferenceService _preferenceService;

  SettingsViewModel(this._preferenceService);

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await _preferenceService.initializationFuture;
    // TODO use GetIt
    tenseFilters = _preferenceService.loadTenses();
    pronounFilters = _preferenceService.loadPronouns();
    favouriteFilter = _preferenceService.loadVerbFavouriteFilter();
    endingFilter = _preferenceService.loadVerbEndingFilter();
    auxiliaryFilter = _preferenceService.loadAuxiliaryFilter();
    irregularityFilter = _preferenceService.loadVerbIrregularityFilter();
    //_reflexiveFilterPref = preferenceManager.loadReflexiveFiltersPref();
    //_customizedVerbsPrefs = preferenceManager.loadCustomizedVerbsPrefs();
  }

  // Update & Notify
  List<Verb> _verbs = [];

  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    if (ListEquality().equals(_verbs, verbs)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }

    _verbs = verbs;
    if(isInitialized) notifyListeners();
    debugPrint("$_logTag | Loaded Verbs Count: ${_verbs.length}");
    debugPrint("$_logTag | Loaded Verbs: ${_verbs.map((e) => e.italianInfinitive)}");
  }

  List<ItalianTense> tenseFilters = [];
  List<Pronoun> pronounFilters = [];
  VerbFavouriteFilter favouriteFilter = VerbFavouriteFilter.all;
  VerbIrregularityFilter irregularityFilter = VerbIrregularityFilter.any;
  VerbEndingFilter endingFilter = VerbEndingFilter.all;
  //late ReflexiveVerb _reflexiveFilterPref;
  //List<Verb> _customizedVerbsPrefs = [];
  AuxiliaryFilter auxiliaryFilter = AuxiliaryFilter.any;

  // Labels
  List<Verb> get verbs => _verbs;

  updateFavouriteFilter(VerbFavouriteFilter filter) {
    debugPrint("$_logTag | updateFavouriteFilter($filter)");
    favouriteFilter = filter;
    _preferenceService.updateVerbFavourite(filter);
    debugPrint("$_logTag | Saved Verb Ending Filter in Shared Preferences: $filter");
    notifyListeners();
  }

  updateIrregularityFilter(VerbIrregularityFilter filter) {
    debugPrint("$_logTag | updateIrregularityFilter($filter)");
    irregularityFilter = filter;
    _preferenceService.updateIrregularityFilter(filter);
    debugPrint("$_logTag | Saved Verb Irregularity Filter in Shared Preferences: $filter");
    notifyListeners();
  }

  updateEndingFilter(VerbEndingFilter filter) {
    debugPrint("$_logTag | updateEndingFilter($filter)");
    endingFilter = filter;
    _preferenceService.updateEndingFilter(endingFilter);
    debugPrint("$_logTag | Saved Verb Ending Filter in Shared Preferences: $filter");
    notifyListeners();
  }

  updateAuxiliaryFilter(AuxiliaryFilter filter) {
    debugPrint("$_logTag | updateAuxiliaryFilter($filter)");
    auxiliaryFilter = filter;
    _preferenceService.updateAuxiliaryFilter(auxiliaryFilter);
    debugPrint("$_logTag | Saved Auxiliary Filter in Shared Preferences: $filter");
    notifyListeners();
  }

/*
  addCustomVerb(Verb verb) {
    _customizedVerbsPrefs.add(verb.prefKey);
    debugPrint("$_logTag | Added ${verb.prefKey}");
    notifyListeners();
  }

  removeCustomVerb(Verb verb) {
    _customizedVerbsPrefs.remove(verb.prefKey);
    debugPrint("$_logTag | Removed ${verb.prefKey}");
    notifyListeners();
  }

  bool isCustomVerbSelected(Verb verb) => _customizedVerbsPrefs.contains(verb.prefKey);*/

  addPronounFilter(Pronoun pronoun) {
    debugPrint("$_logTag | addPronounFilter($pronoun)");
    pronounFilters = List.from(pronounFilters)..add(pronoun);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  selectAllPronounFilters() {
    debugPrint("$_logTag | selectAllPronounFilters()");
    if(UnorderedIterableEquality().equals(pronounFilters, Pronoun.values)) return;
    pronounFilters = List.from(Pronoun.values);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  removePronounFilter(Pronoun pronoun) {
    debugPrint("$_logTag | removePronounFilter($pronoun)");
    pronounFilters = List.from(pronounFilters)..remove(pronoun);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronouns in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  bool isPronounSelected(Pronoun pronoun) => pronounFilters.contains(pronoun);

  addTenseFilter(ItalianTense tense){
    debugPrint("$_logTag | addTenseFilter($tense)");
    tenseFilters = tenseFilters + [tense];
    _preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Tenses in Shared Preferences: $tenseFilters");
    notifyListeners();
  }

  addTenseFilters(List<ItalianTense> tenses) {
    if(tenses.every((tense) => tenseFilters.contains(tense))) return;
    debugPrint("$_logTag | addTenseFilters($tenses)");
    tenseFilters = tenseFilters + tenses;
    _preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  removeTenseFilter(ItalianTense tense){
    debugPrint("$_logTag | removeTenseFilter($tense)");
    tenseFilters = List.from(tenseFilters)..remove(tense);
    _preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Tenses in Shared Preferences: $tenseFilters");
    notifyListeners();
  }

  bool isTenseSelected(ItalianTense tense) => tenseFilters.contains(tense);
}