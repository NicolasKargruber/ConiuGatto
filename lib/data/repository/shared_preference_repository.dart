import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preference_keys.dart';

final _logTag = (SharedPreferenceRepository).toString();

// TODO Move using GetIt
class SharedPreferenceRepository {
  final SharedPreferences _prefs;

  SharedPreferenceRepository._(this._prefs);

  static Future<SharedPreferenceRepository> initialize() async {
    return SharedPreferenceRepository._(await SharedPreferences.getInstance());
  }

  // Verbs
  //String get _customizedVerbsPrefKey => SharedPreferenceKeys.customizedVerbs;
  String get _verbFavouriteFiltersPrefKey => SharedPreferenceKeys.verbFavouriteFilters;
  String get _starredVerbsPrefKey => SharedPreferenceKeys.starredVerbs;
  String get _irregularityFiltersPrefKey => SharedPreferenceKeys.irregularityFilters;
  String get _endingFiltersPrefKey => SharedPreferenceKeys.endingFilters;
  // Tenses
  String get _tensePrefKey => SharedPreferenceKeys.quizzableTenses;
  // Pronoun
  String get _pronounPrefKey => SharedPreferenceKeys.quizzablePronouns;

  // Verbs
  String? loadVerbFavouritePref() => _loadPrefOrNull(_verbFavouriteFiltersPrefKey);
  String? loadIrregularityFilterPref() => _loadPrefOrNull(_irregularityFiltersPrefKey);
  String? loadEndingFilterPref() => _loadPrefOrNull(_endingFiltersPrefKey);
  List<String>? loadStarredVerbPrefs() => _loadPrefsOrNull(_starredVerbsPrefKey)?.toList();
  //loadCustomizedVerbsPrefs() => _loadPrefs(_customizedVerbsPrefKey);
  // Tenses
  List<String>? loadTensePrefs() => _loadPrefsOrNull(_tensePrefKey)?.toList();
  // Pronoun
  List<String>? loadPronounPrefs() => _loadPrefsOrNull(_pronounPrefKey)?.toList();

  // Verbs
  void updateVerbFavouritePref(String value) => _updatePref(_verbFavouriteFiltersPrefKey, value);
  void updateIrregularityFilterPref(String value) => _updatePref(_irregularityFiltersPrefKey, value);
  void updateEndingFilterPref(String value) => _updatePref(_endingFiltersPrefKey, value);
  void updateStarredVerbsPrefs(Set<String> values) => _updatePrefs(_starredVerbsPrefKey, values);
  void addStarredVerbFromPrefs(String value) {
    final starredVerbs = loadStarredVerbPrefs()?.toSet() ?? {};
    updateStarredVerbsPrefs(starredVerbs..add(value));
  }
  //updateCustomizedVerbsPrefs(Set<String> values) => _updatePrefs(_customizedVerbsPrefKey, values);
  // Tenses
  void updateTensePrefs(Set<String> values) => _updatePrefs(_tensePrefKey, values);
  // Pronoun
  void updatePronounPrefs(Set<String> values) => _updatePrefs(_pronounPrefKey, values);

  // Verbs
  void removeVerbFavouritePref() => _removePref(_verbFavouriteFiltersPrefKey);
  void removeIrregularityFilterPref() => _removePref(_irregularityFiltersPrefKey);
  void removeEndingFilterPref() => _removePref(_endingFiltersPrefKey);
  void removeStarredVerbFromPrefs(String value) {
    final starredVerbs = loadStarredVerbPrefs()?.toSet() ?? {};
    updateStarredVerbsPrefs(starredVerbs..remove(value));
  }
  //removeCustomizedVerbsPrefs() => _removePref(_customizedVerbsPrefKey);

  // Private Helpers
  String? _loadPrefOrNull(String key, {String? defaultValue}) {
    debugPrint('$_logTag | _loadPrefOrNull($key)');
    final pref = _prefs.getString(key) ?? defaultValue;
    debugPrint('$_logTag | Available $key Pref: $pref');
    return pref;
  }

  // Private Helpers
  Set<String>? _loadPrefsOrNull(String key) {
    debugPrint('$_logTag | _loadPrefsOrNull($key)');
    final prefs = _prefs.getStringList(key)?.toSet();
    debugPrint('$_logTag | Available $key Prefs: $prefs');
    return prefs;
  }

  // Private Helpers
  void _updatePref(String key, String value) {
    debugPrint('$_logTag | _updatePref($key)');
    _prefs.setString(key, value);
    debugPrint('$_logTag | Updated $key Pref: $value');
  }

  // Private Helpers
  void _updatePrefs(String key, Set<String> values) {
    debugPrint('$_logTag | _loadPrefs($key)');
    _prefs.setStringList(key, values.toList());
    debugPrint('$_logTag | Updated $key Prefs: $values');
  }

  // Private Helpers
  void _removePref(String key) {
    debugPrint('$_logTag | _removePref($key)');
    _prefs.remove(key);
    debugPrint('$_logTag | Removed $key Pref');
  }
}
