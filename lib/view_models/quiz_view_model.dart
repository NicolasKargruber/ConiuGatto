import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/shared_preference_keys.dart';
import '../models/auxiliary.dart';
import '../models/pronoun.dart';
import '../models/quizzable_tense.dart';
import '../models/verb.dart';
import '../utilities/extensions/iterable_extensions.dart';
import '../utilities/extensions/string_extensions.dart';
import 'view_model.dart';

class QuizViewModel extends ViewModel {
  final _logTag = (QuizViewModel).toString();

  // Shared Preferences
  SharedPreferences? _prefs;
  final Set<String> _tensePrefs = {};
  final Set<String> _verbPrefs = {};
  final Set<String> _pronounPrefs = {};

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _prefs = await SharedPreferences.getInstance();
    createQuizItem();
  }

  // Update & Notify
  List<Verb> _verbs = [];
  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    Function eq = const ListEquality().equals;
    if(eq(_verbs, verbs)) return debugPrint("$_logTag | loaded verbs are still the same");
    _verbs = verbs;
    //notifyListeners();
    createQuizItem();
  }

  // Quizzable State
  Verb? _currentVerb;
  final List<Verb> _quizzableVerbs = [];
  final List<QuizzableTense> _quizzableTenses = [];
  QuizzableTense? _currentQuizzableTense;
  final List<Pronoun> _quizzablePronouns = [];
  Pronoun? _currentPronoun;
  String? _currentAnswer;

  // Getters - Quiz State
  String? get _currentSolution => _currentQuizzableTense?.solution(_currentPronoun);
  Auxiliary? get currentAuxiliary => _currentQuizzableTense?.auxiliary;
  bool get isDoubleAuxiliary => _currentQuizzableTense?.verb.isDoubleAuxiliary ?? false;
  bool get hasQuizzableItems => _quizzableVerbs.isNotEmpty && _quizzableTenses.isNotEmpty && _quizzablePronouns.isNotEmpty;

  // Getters - Quiz Labels
  String? get currentTitle => _currentQuizzableTense?.currentTitle;
  String? get currentQuestion => _currentQuizzableTense?.question(_currentPronoun);
  String? get currentTranslation => _currentQuizzableTense?.translation(_currentPronoun);

  void _findQuizzableVerbs() {
    debugPrint("$_logTag | _findQuizzableVerbs() started");
    _loadPrefs(SharedPreferenceKeys.quizzableVerbs, _verbPrefs);
    _quizzableVerbs.clear();
    _quizzableVerbs.addAll(_verbs.where((verb) => _verbPrefs.contains(verb.prefKey)));
    debugPrint("$_logTag | Quizzable Verb Count: ${_quizzableVerbs.length}");
    debugPrint("$_logTag | _findQuizzableVerbs() ended");
  }

  void _findQuizzableTenses() {
    debugPrint("$_logTag | _findQuizzableTenses() started");
    _loadPrefs(SharedPreferenceKeys.quizzableTenses, _tensePrefs);
    _quizzableTenses.clear();

    if (_currentVerb == null) {
      return debugPrint("$_logTag | No current Verb -> Cannot find QuizzableTenses");
    }

    for (final auxiliary in _currentVerb!.auxiliaries) {
      for (final mood in _currentVerb!.moods) {
        final tenses = mood.getTenses(auxiliary);
        for (final tense in tenses) {
          final prefKey = tense.runtimeType.toString();
          if (!_tensePrefs.contains(prefKey)) continue;
          final quizzableTense = QuizzableTense(verb: _currentVerb!, auxiliary: auxiliary, mood: mood, tense: tense);
          if(quizzableTense.hasConjugatedVerbs) _quizzableTenses.add(quizzableTense);
        }
      }
    }

    debugPrint("$_logTag | QuizzableTense Count: ${_quizzableTenses.length}");
    debugPrint("$_logTag | _findQuizzableTenses() ended");
  }

  void _findQuizzablePronouns() {
    debugPrint("$_logTag | _findQuizzablePronouns() started");
    _loadPrefs(SharedPreferenceKeys.quizzablePronouns, _pronounPrefs);
    _quizzablePronouns.clear();
    _quizzablePronouns.addAll(Pronoun.values.where((pronoun) => _pronounPrefs.contains(pronoun.prefKey)));
    debugPrint("$_logTag | Quizzable Pronoun Count: ${_quizzablePronouns.length}");
    debugPrint("$_logTag | _findQuizzablePronouns() ended");
  }

  createQuizItem() {
    debugPrint("$_logTag | createQuizItem() started");
    if (_verbs.isEmpty) {
      notifyListeners();
      return debugPrint("$_logTag | no verbs to randomize");
    }

    // Find Quizzable Verb
    _findQuizzableVerbs();
    _currentVerb = _quizzableVerbs.randomElementOrNull;

    // Find Quizzable Tense, Pronoun & Solution
    _findQuizzableTenses();
    _findQuizzablePronouns();
    _randomizeQuizItem();

    if(!hasQuizzableItems) {
      notifyListeners();
      if (_quizzableVerbs.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Verbs found");
      } else if (_quizzableTenses.isEmpty) {
        return debugPrint("$_logTag | No QuizzableTenses found");
      } else if (_quizzablePronouns.isEmpty) {
        return debugPrint("$_logTag | No Quizzable Pronouns found");
      }
    }

    while (_currentSolution == null){
      debugPrint("$_logTag | Re-Randomize Quiz Item");
      _randomizeQuizItem();

      // TODO check for previous Quiz being the same
      /*final newQuizzableTense = _quizzableTenses.randomElementOrNull;
      if(newQuizzableTense == _currentQuizzableTense) {
        debugPrint("$_logTag | QuizzableTense is still the same");
        continue;
      }
      _currentQuizzableTense = newQuizzableTense;*/
    }

    debugPrint("$_logTag | Current Verb: ${_currentVerb?.infinitive}");
    debugPrint("$_logTag | Solution: (${_currentPronoun?.italian}) $_currentSolution");

    notifyListeners();
    debugPrint("$_logTag | createQuizItem() ended");
  }

  void _randomizeQuizItem() {
    _currentVerb = _quizzableVerbs.randomElementOrNull;
    _currentQuizzableTense = _quizzableTenses.randomElementOrNull;
    _currentPronoun = _quizzablePronouns.randomElementOrNull;
  }

  isAnswerCorrect(String answer) {
    debugPrint("$_logTag | isAnswerCorrect()");
    _currentAnswer = answer;
    final usingEssere = _currentQuizzableTense?.auxiliary.requiresGenderedParticiple ?? false;
    final usingParticiple = _currentQuizzableTense?.tense.usesPastParticiple ?? false;
    if (usingEssere && usingParticiple) {
      _currentAnswer = _currentPronoun?.genderItalianConjugationIfPossible(answer);
    }
    debugPrint("$_logTag | Formatted Answer : $_currentAnswer");
    return _currentAnswer == _currentSolution;
  }

  printDifferences() {
    debugPrint("$_logTag | printDifferences() started");
    _currentAnswer?.printDifferences(_currentSolution ?? '');
    debugPrint("$_logTag | printDifferences() ended");
  }

  // Private Helpers
  void _loadPrefs(String key, Set<String> targetSet) {
    debugPrint('$_logTag | _loadPrefs($key)');
    targetSet.clear();
    targetSet.addAll(_prefs?.getStringList(key) ?? []);
    debugPrint('$_logTag | Available $key Prefs: $targetSet');
    notifyListeners();
  }
}
