import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/verb.dart';
import 'view_model.dart';

class VerbViewModel extends ViewModel{

  List<Verb> _verbs = [];
  List<Verb> get verbs => [..._verbs];

  // Constructor
  VerbViewModel(){
    loadVerbs();
  }

  Future loadVerbs() async {
    if(isLoading) return;
    //if(currentFuture == null) return currentFuture = loadVerbs();

    debugPrint("VerbViewModel | loadVerbs() started");
    toggleLoading();
    final String response = await rootBundle.loadString('assets/data/verbs.json');
    final List<dynamic> data = json.decode(response);
    _verbs = data.map((json) => Verb.fromJson(json)).toList();
    toggleLoading();
    debugPrint("VerbViewModel | loadVerbs() ended");
  }
}
