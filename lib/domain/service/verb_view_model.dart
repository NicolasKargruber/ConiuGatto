import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../data/models/verb.dart';
import '../../presentation/view_model.dart';

final _logTag = (VerbViewModel).toString();

class VerbViewModel extends ViewModel{

  List<Verb> _verbs = [];
  List<Verb> get verbs => [..._verbs];

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await loadVerbs();
  }

  Future loadVerbs() async {
    if(isLoading) return;
    //if(currentFuture == null) return currentFuture = loadVerbs();

    debugPrint("$_logTag | loadVerbs() started");
    toggleLoading();
    try {
      final String response = await rootBundle.loadString('assets/data/verbs.json');
      final data = await compute(json.decode, response) as List<dynamic>;
      _verbs = data.map((json) => Verb.fromJson(json)).toList();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
    } finally {
      toggleLoading();
      debugPrint("$_logTag | verbs: ${verbs.map((e) => e.italianInfinitive).toList()}");
      debugPrint("$_logTag | loadVerbs() ended");
    }
  }
}
