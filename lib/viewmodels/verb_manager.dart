import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/verb.dart';

class VerbViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Verb> _verbs = [];
  List<Verb> get verbs => [..._verbs];

  // Constructor
  VerbViewModel(){
    loadVerbs();
  }

  toggleLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future loadVerbs() async {
    if(_isLoading) return;
    toggleLoading();
    final String response = await rootBundle.loadString('assets/data/verbs.json');
    final List<dynamic> data = json.decode(response);
    _verbs = data.map((json) => Verb.fromJson(json)).toList();
    toggleLoading();
  }
}
