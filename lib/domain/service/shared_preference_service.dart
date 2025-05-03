import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/enums/italian_tense.dart';
import '../../utilities/shared_preference_keys.dart';
import '../../data/enums/pronoun.dart';
import 'service.dart';

typedef SharedPreference = ({String key, String value});

final _logTag = (SharedPreferenceService).toString();

class SharedPreferenceService extends Service {
  late final SharedPreferences _prefs;

  SharedPreferenceService();

  @override
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get _verbPrefKey => SharedPreferenceKeys.quizzableVerbs;
  String get _tensePrefKey => SharedPreferenceKeys.quizzableTenses;
  String get _pronounPrefKey => SharedPreferenceKeys.quizzablePronouns;

  final _tensesDefaultValue = [ItalianTense.presentIndicative.prefKey];
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
