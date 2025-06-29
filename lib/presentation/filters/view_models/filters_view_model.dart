import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/auxiliary_filter.dart';
import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../domain/models/enums/verb_ending_filter.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/enums/verb_irregularity_filter.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/language_level_extensions.dart';
import '../../../domain/utils/mood_extensions.dart';
import '../../view_model.dart';

class FiltersViewModel extends ViewModel {
  static final _logTag = (FiltersViewModel).toString();

  final SharedPreferenceService _preferenceService;

  FiltersViewModel(this._preferenceService);

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await _preferenceService.initializationFuture;
    // TODO use GetIt
    tenseFilters = _preferenceService.loadTenses().toSet();
    pronounFilters = _preferenceService.loadPronouns();
    favouriteFilter = _preferenceService.loadVerbFavouriteFilter();
    auxiliaryFilter = _preferenceService.loadAuxiliaryFilter();
    endingFilter = _preferenceService.loadVerbEndingFilter();
    irregularityFilter = _preferenceService.loadVerbIrregularityFilter();
  }

  // Update & Notify
  List<Verb> _verbs = [];

  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    if (ListEquality().equals(_verbs, verbs)) {
      return debugPrint("$_logTag | loaded verbs are still the same");
    }

    _verbs = verbs;
    if (isInitialized) notifyListeners();
    debugPrint("$_logTag | Loaded Verbs Count: ${_verbs.length}");
    debugPrint("$_logTag | Loaded Verbs: ${_verbs.map((e) => e.italianInfinitive)}");
  }

  Set<ItalianTense> tenseFilters = {};
  List<Pronoun> pronounFilters = [];
  VerbFavouriteFilter? favouriteFilter;
  AuxiliaryFilter? auxiliaryFilter = AuxiliaryFilter.any;
  VerbEndingFilter? endingFilter;
  VerbIrregularityFilter? irregularityFilter;

  // Labels
  List<Verb> get verbs => _verbs;

  updateFavouriteFilter(VerbFavouriteFilter filter) {
    debugPrint("$_logTag | updateFavouriteFilter($filter)");
    favouriteFilter = filter;
    _preferenceService.updateVerbFavourite(filter);
    debugPrint("$_logTag | Saved Verb Ending Filter in Shared Preferences: $filter");
    notifyListeners();
  }

  updateAuxiliaryFilter(AuxiliaryFilter filter) {
    debugPrint("$_logTag | updateAuxiliaryFilter($filter)");
    auxiliaryFilter = filter;
    _preferenceService.updateAuxiliaryFilter(filter);
    debugPrint("$_logTag | Saved Auxiliary Filter in Shared Preferences: $filter");
    notifyListeners();
  }

  updateEndingFilter(VerbEndingFilter filter) {
    debugPrint("$_logTag | updateEndingFilter($filter)");
    endingFilter = filter;
    _preferenceService.updateEndingFilter(filter);
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

  addPronounFilter(Pronoun pronoun) {
    debugPrint("$_logTag | addPronounFilter($pronoun)");
    pronounFilters = List.from(pronounFilters)
      ..add(pronoun);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  selectAllPronounFilters() {
    debugPrint("$_logTag | selectAllPronounFilters()");
    if (UnorderedIterableEquality().equals(pronounFilters, Pronoun.values)) return;
    pronounFilters = List.from(Pronoun.values);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  removePronounFilter(Pronoun pronoun) {
    debugPrint("$_logTag | removePronounFilter($pronoun)");
    pronounFilters = List.from(pronounFilters)
      ..remove(pronoun);
    _preferenceService.updatePronounPrefs(pronounFilters);
    debugPrint("$_logTag | Saved Pronouns in Shared Preferences: $pronounFilters");
    notifyListeners();
  }

  bool isPronounSelected(Pronoun pronoun) => pronounFilters.contains(pronoun);

  addTenseFilter(ItalianTense tense) {
    debugPrint("$_logTag | addTenseFilter($tense)");
    tenseFilters = {...tenseFilters, tense};
    _preferenceService.updateTensePrefs(tenseFilters.toList());
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences");
    notifyListeners();
  }

  addTenseFilters(List<ItalianTense> tenses) {
    if (tenses.every((tense) => tenseFilters.contains(tense))) return;
    debugPrint("$_logTag | addTenseFilters($tenses)");
    tenseFilters = {...tenseFilters, ...tenses};
    _preferenceService.updateTensePrefs(tenseFilters.toList());
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences");
    notifyListeners();
  }

  removeTenseFilter(ItalianTense tense) {
    debugPrint("$_logTag | removeTenseFilter($tense)");
    tenseFilters = {...tenseFilters}..remove(tense);
    _preferenceService.updateTensePrefs(tenseFilters.toList());
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences");
    notifyListeners();
  }

  removeTenseFilters(List<ItalianTense> tenses) {
    debugPrint("$_logTag | removeTenseFilters($tenses)");
    tenseFilters = {...tenseFilters}..removeAll(tenses);
    _preferenceService.updateTensePrefs(tenseFilters.toList());
    debugPrint("$_logTag | Saved Pronoun in Shared Preferences");
    notifyListeners();
  }

  bool isTenseSelected(ItalianTense tense) => tenseFilters.contains(tense);

  bool coversLanguageLevel(LanguageLevel level) => tenseFilters.containsAll(level.coveredTenses);
  bool coversMood(Mood mood) => tenseFilters.containsAll(mood.tenses);
}