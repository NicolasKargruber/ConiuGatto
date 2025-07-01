import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../data/enums/italian_auxiliary.dart';
import '../../../domain/models/tenses/tense.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/url_helper.dart';
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
    _isStarred = _preferenceService.getStarredVerbsFrom([_verb]).contains(_verb);
    notifyListeners();
  }

  // State
  late ItalianAuxiliary _selectedAuxiliary;
  ItalianAuxiliary get selectedAuxiliary => _selectedAuxiliary;
  bool _isStarred = false;
  bool get isStarred => _isStarred;


  // Getters - State
  bool get isRegular => _verb.isRegular;
  bool get isDoubleAuxiliary => _verb.isDoubleAuxiliary;
  List<Tense> get indicativeTenses => _verb.getIndicativeTenses(_selectedAuxiliary);
  List<Tense> get subjunctiveTenses => _verb.getSubjunctiveTenses(_selectedAuxiliary);
  List<Tense> get conditionalTenses => _verb.getConditionalTenses(_selectedAuxiliary);
  List<Tense> get imperativeTenses => _verb.getImperativeTenses();
  List<String> get auxiliaryLabels => _verb.auxiliaries.map((e) => e.label).toList();
  int get selectedAuxiliaryIndex => _selectedAuxiliary.index;

  // Getters - Quiz Labels
  String get italianInfinitive => _verb.italianInfinitive;
  String getTranslation(BuildContext context) => _verb.getTranslation(context);

  updateStarred(bool star) {
    debugPrint("$_logTag | updateStarred($star)");
    _isStarred = star;
    if (star) {
      _preferenceService.addStarredVerb(_verb);
      debugPrint("$_logTag | Added starred verb: ${_verb.prefKey}");
    } else {
      _preferenceService.removeStarredVerb(_verb);
      debugPrint("$_logTag | Removed starred verb: ${_verb.prefKey}");
    }
    notifyListeners();
  }

  selectAuxiliary(ItalianAuxiliary? auxiliary) {
    debugPrint("$_logTag | selectAuxiliaryAtIndex($auxiliary)");
    if(auxiliary == null) return;
    _selectedAuxiliary = auxiliary;
    notifyListeners();
  }

  reportTense(Tense tense){
    debugPrint("$_logTag | reportTense()");
    UrlHelper.sendMailToReportConjugation(_verb.italianInfinitive, tense.extendedLabel);
  }
}
