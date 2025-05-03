import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/enums/italian_tense.dart';
import '../../../domain/models/verb.dart';
import '../../../main.dart';
import '../../view_model.dart';

final _logTag = (SettingsViewModel).toString();

class SettingsViewModel extends ViewModel {

  @override
  Future initialize() async {
    // TODO use GetIt
    _tensePrefs = preferenceManager.loadTensePrefs();
    _pronounPrefs = preferenceManager.loadPronounPrefs();
    // TODO use enums
    _verbPrefs = preferenceManager.loadVerbPrefs(_defaultVerbPrefs);
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

  // SharedPreferences
  Set<String> _tensePrefs = {};
  Set<String> _pronounPrefs = {};
  Set<String> _verbPrefs = {};
  // TODO use enum
  get _defaultVerbPrefs => _verbs.map((e) => e.prefKey);

  // Labels
  List<Verb> get verbs => _verbs;

  addVerb(Verb verb) {
    _verbPrefs.add(verb.prefKey);
    debugPrint("$_logTag | Added ${verb.prefKey}");
    notifyListeners();
  }

  removeVerb(Verb verb) {
    _verbPrefs.remove(verb.prefKey);
    debugPrint("$_logTag | Removed ${verb.prefKey}");
    notifyListeners();
  }

  bool isVerbSelected(Verb verb) => _verbPrefs.contains(verb.prefKey);

  addPronoun(Pronoun pronoun) {
    _pronounPrefs.add(pronoun.prefKey);
    debugPrint("$_logTag | Added ${pronoun.prefKey}");
    notifyListeners();
  }

  removePronoun(Pronoun pronoun) {
    _pronounPrefs.remove(pronoun.prefKey);
    debugPrint("$_logTag | Removed ${pronoun.prefKey}");
    notifyListeners();
  }

  bool isPronounSelected(Pronoun pronoun) => _pronounPrefs.contains(pronoun.prefKey);

  addTense(ItalianTense tense){
    _tensePrefs.add(tense.prefKey);
    debugPrint("$_logTag | Added ${tense.prefKey}");
    notifyListeners();
  }

  removeTense(ItalianTense tense){
    _tensePrefs.remove(tense.prefKey);
    debugPrint("$_logTag | Removed ${tense.prefKey}");
    notifyListeners();
  }

  bool isTenseSelected(ItalianTense tense) => _tensePrefs.contains(tense.prefKey);

  savePrefs(){
    debugPrint("$_logTag | savePrefs()");
    preferenceManager.updateVerbPrefs(_verbPrefs);
    debugPrint("$_logTag | Saved Verb Prefs: $_verbPrefs");
    preferenceManager.updatePronounPrefs(_pronounPrefs);
    debugPrint("$_logTag | Saved Pronoun Prefs: $_pronounPrefs");
    preferenceManager.updateTensePrefs(_tensePrefs);
    debugPrint("$_logTag | Saved Tense Prefs: $_tensePrefs");
  }
}