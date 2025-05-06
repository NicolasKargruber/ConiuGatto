import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/verb.dart';
import '../../view_model.dart';

final _logTag = (SearchViewModel).toString();

class SearchViewModel extends ViewModel{
  List<Verb> _filteredVerbs = [];
  List<Verb> get filteredVerbs =>
      [..._filteredVerbs.isEmpty ? _verbs : _filteredVerbs];

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
  }

  // Update & Notify
  List<Verb> _verbs = [];
  updateVerbs(List<Verb> verbs) {
    debugPrint("$_logTag | updateVerbs()");
    // Check if verbs are the same
    Function eq = const ListEquality().equals;
    if(eq(_verbs, verbs)) return debugPrint("$_logTag | loaded verbs are still the same");
    _verbs = verbs;
  }

  filterVerbs(String search) {
    debugPrint("$_logTag | filterVerbs()");
    search = search.toLowerCase();
    final filteredVerbsInItalian = _verbs.where((verb) => verb.italianInfinitive.contains(search)).toList();
    final filteredVerbsInEnglish = _verbs.where((verb) => verb.infinitive.english.contains(search)).toList();
    _filteredVerbs = filteredVerbsInItalian + filteredVerbsInEnglish;
    notifyListeners();
  }
}
