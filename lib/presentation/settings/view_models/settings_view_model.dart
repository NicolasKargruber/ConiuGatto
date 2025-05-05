import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/enums/reflexive_verb.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/enums/verb_irregularity_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../main.dart';
import '../../view_model.dart';

final _logTag = (SettingsViewModel).toString();

class SettingsViewModel extends ViewModel {

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    // TODO use GetIt
    tenseFilters = preferenceService.loadTenses();
    pronounFilters = preferenceService.loadPronouns();
    verbFavouriteFilter = preferenceService.loadVerbFavouriteFilter();
    irregularityFilter = preferenceService.loadVerbIrregularityFilter();
    endingFilter = preferenceService.loadVerbEndingFilter();
    //_reflexiveFilterPref = preferenceManager.loadReflexiveFiltersPref();
    // TODO use enums
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
    notifyListeners();
    debugPrint("$_logTag | Loaded Verbs Count: ${_verbs.length}");
    debugPrint("$_logTag | Loaded Verbs: ${_verbs.map((e) => e.italianInfinitive)}");
  }

  // TODO Move all to SharedPreferences
  List<ItalianTense> tenseFilters = [];
  List<Pronoun> pronounFilters = [];
  late VerbFavouriteFilter verbFavouriteFilter;
  late VerbIrregularityFilter irregularityFilter;
  late VerbEndingFilter endingFilter;
  //late ReflexiveVerb _reflexiveFilterPref;
  //List<Verb> _customizedVerbsPrefs = [];

  // Labels
  List<Verb> get verbs => _verbs;

  updateVerbFavouriteFilter(VerbFavouriteFilter filter) {
    verbFavouriteFilter = filter;
    debugPrint("$_logTag | Updated ${filter.prefKey}");
    notifyListeners();
  }

  bool isVerbFavouriteFilterSelected(VerbFavouriteFilter filter) => verbFavouriteFilter == filter;

  updateIrregularityFilter(VerbIrregularityFilter filter) {
    irregularityFilter = filter;
    debugPrint("$_logTag | Updated ${filter.prefKey}");
    notifyListeners();
  }

  bool isIrregularityFilterSelected(VerbIrregularityFilter filter) => irregularityFilter == filter;

  updateEndingFilter(VerbEndingFilter filter) {
    endingFilter = filter;
    debugPrint("$_logTag | Updated ${filter.prefKey}");
    notifyListeners();
  }

  bool isEndingFilterSelected(VerbEndingFilter filter) => endingFilter == filter;
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
    pronounFilters.add(pronoun);
    debugPrint("$_logTag | Added ${pronoun.prefKey}");
    notifyListeners();
  }

  removePronounFilter(Pronoun pronoun) {
    pronounFilters.remove(pronoun);
    debugPrint("$_logTag | Removed ${pronoun.prefKey}");
    notifyListeners();
  }

  bool isPronounFilterSelected(Pronoun pronoun) => pronounFilters.contains(pronoun);

  addTenseFilter(ItalianTense tense){
    tenseFilters.add(tense);
    debugPrint("$_logTag | Added ${tense.prefKey}");
    notifyListeners();
  }

  removeTenseFilter(ItalianTense tense){
    tenseFilters.remove(tense);
    debugPrint("$_logTag | Removed ${tense.prefKey}");
    notifyListeners();
  }

  bool isTenseSelected(ItalianTense tense) => tenseFilters.contains(tense);

  savePrefs(){
    debugPrint("$_logTag | savePrefs()");
    //preferenceManager.updateCustomizedVerbsPrefs(_customizedVerbsPrefs);
    // debugPrint("$_logTag | Saved Verb Prefs: $_customizedVerbsPrefs");
    preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun Prefs: $pronounFilters");
    preferenceService.updateTensePrefs(tenseFilters);
    debugPrint("$_logTag | Saved Tense Prefs: $tenseFilters");
  }
}