import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/auxiliary.dart';
import '../../../domain/models/tenses/tense.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../view_model.dart';
import '../../../domain/utils/verb_extensions.dart';


class VerbDetailViewModel extends ViewModel {
  static final _logTag = (VerbDetailViewModel).toString();

  final Verb _verb;
  final SharedPreferenceService _preferenceService;

  VerbDetailViewModel(this._verb, this._preferenceService);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _verb.auxiliaries.sortBy((e) => e.index);
    _selectedAuxiliary = _verb.auxiliaries.first;
    debugPrint("$_logTag | Irregularities: ${_verb.irregularities}");
    await _preferenceService.initializationFuture;
    _starredVerbPrefs = _preferenceService.getStarredVerbFrom([_verb]);
    notifyListeners();
  }

  // State
  late Auxiliary _selectedAuxiliary;
  List<bool> selectedAuxiliaries = [true, false];
  List<String> _starredVerbPrefs = [];

  // Getters - State
  bool get isRegular => _verb.isRegular;
  bool get isDoubleAuxiliary => _verb.isDoubleAuxiliary;
  List<Tense> get indicativeTenses => _verb.getIndicativeTenses(_selectedAuxiliary);
  List<Tense> get subjunctiveTenses => _verb.getSubjunctiveTenses(_selectedAuxiliary);
  List<Tense> get conditionalTenses => _verb.getConditionalTenses(_selectedAuxiliary);
  List<Tense> get imperativeTenses => _verb.getImperativeTenses();
  List<String> get auxiliaryLabels => _verb.auxiliaries.map((e) => e.name.toUpperCase()).toList();
  int get selectedAuxiliaryIndex => _selectedAuxiliary.index;
  bool get isStarred => _starredVerbPrefs.contains(_verb.prefKey);

  // Getters - Quiz Labels
  String get italianInfinitive => _verb.italianInfinitive;
  String get translation => _verb.translation;

  updateStarred(bool star) {
    debugPrint("$_logTag | updateStarred($star)");
    if (star) {
      _starredVerbPrefs.add(_verb.prefKey);
      _preferenceService.addStarredVerb(_verb);
      debugPrint("$_logTag | Added starred verb: ${_verb.prefKey}");
    } else {
      _starredVerbPrefs.remove(_verb.prefKey);
      _preferenceService.removeStarredVerb(_verb);
      debugPrint("$_logTag | Removed starred verb: ${_verb.prefKey}");
    }
    notifyListeners();
  }

  selectAuxiliaryAtIndex(index) {
    _selectedAuxiliary = _verb.auxiliaries.elementAt(index);
    selectedAuxiliaries = [false, false];
    selectedAuxiliaries[index] = true;
    notifyListeners();
  }
}
