import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/shared_preference_keys.dart';
import 'enums/pronoun.dart';
import 'models/tenses/indicative_tenses.dart';

typedef SharedPreference = ({String key, String value});

final _logTag = (SharedPreferenceManager).toString();

class SharedPreferenceManager {
  final SharedPreferences _prefs;

  SharedPreferenceManager._(this._prefs);

  static Future<SharedPreferenceManager> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPreferenceManager._(prefs);
  }

  String get _verbPrefKey => SharedPreferenceKeys.quizzableVerbs;
  String get _tensePrefKey => SharedPreferenceKeys.quizzableTenses;
  String get _pronounPrefKey => SharedPreferenceKeys.quizzablePronouns;

  final _tensesDefaultValue = {(PresentIndicative).toString()};
  final _pronounsDefaultValue = Pronoun.values.map((e)=> e.prefKey);

  loadVerbPrefs(Iterable<String> defaultValue) => _loadPrefs(_verbPrefKey, defaultValue);
  loadTensePrefs() => _loadPrefs(_tensePrefKey, _tensesDefaultValue);
  loadPronounPrefs() => _loadPrefs(_pronounPrefKey, _pronounsDefaultValue);

  updateVerbPrefs(Set<String> newValues) => _updatePrefs(_verbPrefKey, newValues);
  updateTensePrefs(Set<String> newValues) => _updatePrefs(_tensePrefKey, newValues);
  updatePronounPrefs(Set<String> newValues) => _updatePrefs(_pronounPrefKey, newValues);

  // Private Helpers
  Set<String> _loadPrefs(String key, Iterable<String> defaultValue) {
    debugPrint('$_logTag | _loadPrefs($key)');
    final Set<String> prefs = {};
    prefs.addAll(_prefs.getStringList(key) ?? defaultValue);
    debugPrint('$_logTag | Available $key Prefs: $prefs');
    return prefs;
  }

  // Private Helpers
  void _updatePrefs(String key, Set<String> newValues) {
    debugPrint('$_logTag | _loadPrefs($key)');
    _prefs.setStringList(key, newValues.toList());
    debugPrint('$_logTag | Updated $key Prefs: $newValues');
  }
}
