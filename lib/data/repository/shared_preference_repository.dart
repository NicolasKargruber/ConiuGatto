import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/shared_preference_keys.dart';

// TODO Move using GetIt
class SharedPreferenceRepository {
  static final _logTag = (SharedPreferenceRepository).toString();
  final SharedPreferences _prefs;

  SharedPreferenceRepository._(this._prefs);

  static Future<SharedPreferenceRepository> initialize() async {
    debugPrint("$_logTag | initialize()");
    return SharedPreferenceRepository._(await SharedPreferences.getInstance());
  }

  // Introduction
  bool? loadSkipIntroductionPref() => _loadPrefBoolOrNull(SharedPreferenceKeys.skipIntroduction);
  void updateSkipIntroductionPref(bool value) => _updatePrefBool(SharedPreferenceKeys.skipIntroduction, value);

  // Localization
  String? loadLocale() => _loadPrefStringOrNull(SharedPreferenceKeys.languageCode);
  void updateLocale(String value) => _updatePrefString(SharedPreferenceKeys.languageCode, value);

  // InAppReview
  int? loadLaunchCount() => _loadPrefIntOrNull(SharedPreferenceKeys.launchCount);
  void updateLaunchCount(int value) => _updatePrefInt(SharedPreferenceKeys.launchCount, value);

  // Verbs
  String get _starredVerbsPrefKey => SharedPreferenceKeys.starredVerbs;
  String get _verbFavouriteFiltersPrefKey => SharedPreferenceKeys.verbFavouriteFilter;
  String get _irregularityFiltersPrefKey => SharedPreferenceKeys.irregularityFilter;
  String get _endingFiltersPrefKey => SharedPreferenceKeys.endingFilter;
  String get _auxiliaryFilterPrefKey => SharedPreferenceKeys.auxiliaryFilter;
  // Tenses
  String get _tensePrefKey => SharedPreferenceKeys.quizzableTenses;
  // Pronoun
  String get _pronounPrefKey => SharedPreferenceKeys.quizzablePronouns;
  // Language Level
  String get _languageLevelPrefKey => SharedPreferenceKeys.languageLevel;

  // Verbs
  List<String>? loadStarredVerbPrefs() => _loadPrefStringListOrNull(_starredVerbsPrefKey)?.toList();
  String? loadVerbFavouritePref() => _loadPrefStringOrNull(_verbFavouriteFiltersPrefKey);
  String? loadIrregularityFilterPref() => _loadPrefStringOrNull(_irregularityFiltersPrefKey);
  String? loadEndingFilterPref() => _loadPrefStringOrNull(_endingFiltersPrefKey);
  String? loadAuxiliaryFilterPref() => _loadPrefStringOrNull(_auxiliaryFilterPrefKey);
  // Tenses
  List<String>? loadTensePrefs() => _loadPrefStringListOrNull(_tensePrefKey)?.toList();
  // Pronoun
  List<String>? loadPronounPrefs() => _loadPrefStringListOrNull(_pronounPrefKey)?.toList();
  // Language Level
  String? loadLanguageLevelPref() => _loadPrefStringOrNull(_languageLevelPrefKey);

  // Verbs
  void updateStarredVerbsPrefs(Set<String> values) => _updateStringList(_starredVerbsPrefKey, values);
  void addStarredVerbFromPrefs(String value) {
    final starredVerbs = loadStarredVerbPrefs()?.toSet() ?? {};
    updateStarredVerbsPrefs(starredVerbs..add(value));
  }
  void updateVerbFavouritePref(String value) => _updatePrefString(_verbFavouriteFiltersPrefKey, value);
  void updateIrregularityFilterPref(String value) => _updatePrefString(_irregularityFiltersPrefKey, value);
  void updateEndingFilterPref(String value) => _updatePrefString(_endingFiltersPrefKey, value);
  void updateAuxiliaryFilterPref(String value) => _updatePrefString(_auxiliaryFilterPrefKey, value);
  //updateCustomizedVerbsPrefs(Set<String> values) => _updatePrefs(_customizedVerbsPrefKey, values);
  // Tenses
  void updateTensePrefs(Set<String> values) => _updateStringList(_tensePrefKey, values);
  // Pronoun
  void updatePronounPrefs(Set<String> values) => _updateStringList(_pronounPrefKey, values);
  // Language Level
  void updateLanguageLevelPref(String value) => _updatePrefString(_languageLevelPrefKey, value);

  // Verbs
  void removeStarredVerbFromPrefs(String value) {
    final starredVerbs = loadStarredVerbPrefs()?.toSet() ?? {};
    updateStarredVerbsPrefs(starredVerbs..remove(value));
  }
  void removeVerbFavouritePref() => _removePref(_verbFavouriteFiltersPrefKey);
  void removeIrregularityFilterPref() => _removePref(_irregularityFiltersPrefKey);
  void removeEndingFilterPref() => _removePref(_endingFiltersPrefKey);

  // Private Helpers
  bool? _loadPrefBoolOrNull(String key, {bool? defaultValue}) {
    debugPrint('$_logTag | _loadPrefBoolOrNull($key)');
    final pref = _prefs.getBool(key) ?? defaultValue;
    debugPrint('$_logTag | Available $key Pref: $pref');
    return pref;
  }

  // Private Helpers
  int? _loadPrefIntOrNull(String key, {int? defaultValue}) {
    debugPrint('$_logTag | _loadPrefIntOrNull($key)');
    final pref = _prefs.getInt(key) ?? defaultValue;
    debugPrint('$_logTag | Available $key Pref: $pref');
    return pref;
  }

  // Private Helpers
  String? _loadPrefStringOrNull(String key, {String? defaultValue}) {
    debugPrint('$_logTag | _loadPrefStringOrNull($key)');
    final pref = _prefs.getString(key) ?? defaultValue;
    debugPrint('$_logTag | Available $key Pref: $pref');
    return pref;
  }

  // Private Helpers
  Set<String>? _loadPrefStringListOrNull(String key) {
    debugPrint('$_logTag | _loadPrefStringListOrNull($key)');
    final prefs = _prefs.getStringList(key)?.toSet();
    if((prefs?.length ?? 0) > 3) {
      debugPrint('$_logTag | Available $key Prefs: [${prefs?.elementAt(0)}, ${prefs?.elementAt(1)} ..., ${prefs?.lastOrNull}]');
    } else {
      debugPrint('$_logTag | Available $key Prefs: $prefs');
    }
    return prefs;
  }

  // Private Helpers
  void _updatePrefInt(String key, int value) {
    debugPrint('$_logTag | _updatePrefInt($key)');
    _prefs.setInt(key, value);
    debugPrint('$_logTag | Updated "$key" Pref: $value');
  }

  // Private Helpers
  void _updatePrefBool(String key, bool value) {
    debugPrint('$_logTag | _updatePrefBool($key)');
    _prefs.setBool(key, value);
    debugPrint('$_logTag | Updated "$key" Pref: $value');
  }

  // Private Helpers
  void _updatePrefString(String key, String value) {
    debugPrint('$_logTag | _updatePrefString($key)');
    _prefs.setString(key, value);
    debugPrint('$_logTag | Updated "$key" Pref: $value');
  }

  // Private Helpers
  void _updateStringList(String key, Set<String> values) {
    debugPrint('$_logTag | _updatePrefStringList($key)');
    _prefs.setStringList(key, values.toList());
    debugPrint('$_logTag | Updated "$key" Prefs: $values');
  }

  // Private Helpers
  void _removePref(String key) {
    debugPrint('$_logTag | _removePref($key)');
    _prefs.remove(key);
    debugPrint('$_logTag | Removed "$key" Pref');
  }
}
