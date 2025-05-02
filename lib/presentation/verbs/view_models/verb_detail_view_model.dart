import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/auxiliary.dart';
import '../../../domain/models/tenses/tense.dart';
import '../../../domain/models/verb.dart';
import '../../view_model.dart';
import '../../../domain/utils/verb_extensions.dart';

final _logTag = (VerbDetailViewModel).toString();

class VerbDetailViewModel extends ViewModel {
  final Verb _verb;

  VerbDetailViewModel(this._verb);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _verb.auxiliaries.sortBy((e) => e.index);
    _selectedAuxiliary = _verb.auxiliaries.first;
    debugPrint("$_logTag | Irregularities: ${_verb.irregularities}");
    debugPrint("$_logTag | Present indicative: ${_verb.presentIndicative.conjugations.toString()}");
  }

  // State
  late Auxiliary _selectedAuxiliary;
  List<bool> selectedAuxiliaries = [true, false];

  // Getters - State
  bool get isRegular => _verb.isRegular;
  bool get isDoubleAuxiliary => _verb.isDoubleAuxiliary;
  List<Tense> get indicativeTenses => _verb.getIndicativeTenses(_selectedAuxiliary, includeGenerated: true);
  List<Tense> get subjunctiveTenses => _verb.getSubjunctiveTenses(_selectedAuxiliary, includeGenerated: true);
  List<Tense> get conditionalTenses => _verb.getConditionalTenses(_selectedAuxiliary, includeGenerated: true);
  List<Tense> get imperativeTenses => _verb.getImperativeTenses(includeGenerated: true);
  List<String> get auxiliaryLabels => _verb.auxiliaries.map((e) => e.name.toUpperCase()).toList();
  int get selectedAuxiliaryIndex => _selectedAuxiliary.index;

  // Getters - Quiz Labels
  String get italianInfinitive => _verb.italianInfinitive;
  String get translation => _verb.translation;

  selectAuxiliaryAtIndex(index) {
    _selectedAuxiliary = _verb.auxiliaries.elementAt(index);
    selectedAuxiliaries = [false, false];
    selectedAuxiliaries[index] = true;
    notifyListeners();
  }
}
