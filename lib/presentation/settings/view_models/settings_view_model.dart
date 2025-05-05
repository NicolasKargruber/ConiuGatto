import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../view_model.dart';

class SettingsViewModel extends ViewModel {
  static final _logTag = (SettingsViewModel).toString();

  final SharedPreferenceService preferenceService;

  SettingsViewModel(this.preferenceService);

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await preferenceService.initializationFuture;
    // TODO use GetIt
    tenseFilters = preferenceService.loadTenses();
    pronounFilters = preferenceService.loadPronouns();
    endingFilter = preferenceService.loadVerbEndingFilter();
    //verbFavouriteFilter = preferenceService.loadVerbFavouriteFilter();
    //irregularityFilter = preferenceService.loadVerbIrregularityFilter();
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
  //late VerbFavouriteFilter verbFavouriteFilter;
  //late VerbIrregularityFilter irregularityFilter;
  VerbEndingFilter endingFilter = VerbEndingFilter.all;
  //late ReflexiveVerb _reflexiveFilterPref;
  //List<Verb> _customizedVerbsPrefs = [];

  // Labels
  List<Verb> get verbs => _verbs;

  /*updateVerbFavouriteFilter(VerbFavouriteFilter filter) {
    preferenceService.updateVerbFavourite(filter);
    debugPrint("$_logTag | Saved Verb Favourite Filter in Shared Preferences: $filter");
    verbFavouriteFilter = filter;
    notifyListeners();
  }

  updateIrregularityFilter(VerbIrregularityFilter filter) {
    preferenceService.updateIrregularityFilter(irregularityFilter);
    debugPrint("$_logTag | Saved Verb Irregularity Filter in Shared Preferences: $irregularityFilter");
    irregularityFilter = filter;
    notifyListeners();
  }*/

  updateEndingFilter(VerbEndingFilter filter) {
    debugPrint("$_logTag | updateEndingFilter($filter)");
    endingFilter = filter;
    preferenceService.updateEndingFilter(endingFilter);
    debugPrint("$_logTag | Saved Verb Ending Filter in Shared Preferences: $endingFilter");
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
    debugPrint("$_logTag | addPronounFilter(${pronoun.prefKey})");
    pronounFilters = List.from(pronounFilters)..add(pronoun);
    preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  removePronounFilter(Pronoun pronoun) {
    debugPrint("$_logTag | removePronounFilter(${pronoun.prefKey})");
    pronounFilters = List.from(pronounFilters)..remove(pronoun);
    preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronouns in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  bool isPronounSelected(Pronoun pronoun) => pronounFilters.contains(pronoun);

  addTenseFilter(ItalianTense tense){
    debugPrint("$_logTag | addTenseFilter(${tense.prefKey})");
    tenseFilters = List.from(tenseFilters)..add(tense);
    preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Tenses in Shared Preferences: $tenseFilters");
    notifyListeners();
  }

  removeTenseFilter(ItalianTense tense){
    debugPrint("$_logTag | removeTenseFilter(${tense.prefKey})");
    tenseFilters = List.from(tenseFilters)..remove(tense);
    preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Tenses in Shared Preferences: $tenseFilters");
    notifyListeners();
  }

  bool isTenseSelected(ItalianTense tense) => tenseFilters.contains(tense);
}