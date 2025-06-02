import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/models/verb.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../view_model.dart';

class SearchViewModel extends ViewModel{
  static final _logTag = (SearchViewModel).toString();

  final SharedPreferenceService _sharedPreferenceService;
  SearchViewModel(this._sharedPreferenceService);

  List<Verb> _starredVerbs = [];

  List<Verb> _filteredVerbs = [];
  List<Verb> get filteredVerbs => [..._filteredVerbs];

  String _searchString = '';
  String get searchString => _searchString;

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
    _starredVerbs = _sharedPreferenceService.getStarredVerbsFrom(_verbs);
    filterVerbs(_searchString);
    notifyListeners();
  }

  updateStarredVerbs() {
    debugPrint("$_logTag | updateStarredVerbs()");
    // Check if verbs are the same
    final starredVerbs = _sharedPreferenceService.getStarredVerbsFrom(_verbs);
    Function eq = const ListEquality().equals;
    if(eq(_verbs, starredVerbs)) return debugPrint("$_logTag | loaded starred verbs are still the same");
    _starredVerbs = starredVerbs;
    notifyListeners();
  }

  filterVerbs(String search) {
    debugPrint("$_logTag | filterVerbs()");
    search = search.toLowerCase();
    _searchString = search;
    Set<Verb> filteredVerbs = {};

    if(search.isEmpty) {
      filteredVerbs = {..._verbs};
    } else {
      final filteredVerbsInItalian = _verbs.where((verb) => verb.italianInfinitive.contains(search)).toList();
      final filteredVerbsInEnglish = _verbs.where((verb) => verb.infinitive.english.contains(search)).toList();
      filteredVerbs = {...filteredVerbsInItalian, ...filteredVerbsInEnglish};
    }

    _filteredVerbs = filteredVerbs.toList();
    notifyListeners();
  }

  toggleStarredVerb(Verb verb) {
    debugPrint("$_logTag | toggleStarredVerb()");
    if(_starredVerbs.contains(verb)) {
      _starredVerbs.remove(verb);
      _sharedPreferenceService.removeStarredVerb(verb);
      notifyListeners();
      debugPrint("$_logTag | Removed starred verb: ${verb.italianInfinitive}");
    } else {
      _starredVerbs.add(verb);
      _sharedPreferenceService.addStarredVerb(verb);
      notifyListeners();
      debugPrint("$_logTag | Added starred verb: ${verb.italianInfinitive}");
    }
  }

  isStarredVerb(Verb verb) => _starredVerbs.contains(verb);
}
