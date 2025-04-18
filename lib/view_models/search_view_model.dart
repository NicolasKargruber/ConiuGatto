import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/verb.dart';
import 'view_model.dart';

class SearchViewModel extends ViewModel{
  final _logTag = (SearchViewModel).toString();

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
    // Update & Sort Verbs
    _verbs = verbs;
    _sortVerbs();
  }

  _sortVerbs() {
    debugPrint("$_logTag | _sortVerbs()");
    _verbs.sort((a, b) => a.italianInfinitive.compareTo(b.italianInfinitive));
    notifyListeners();
  }

  filterVerbs(String search) {
    debugPrint("$_logTag | filterVerbs()");
    search = search.toLowerCase();
    _filteredVerbs = _verbs.where((verb) => verb.italianInfinitive.contains(search)).toList();
    notifyListeners();
  }
}
