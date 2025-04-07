import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/verb.dart';

class VerbManager {
  static Future<List<Verb>> loadVerbs() async {
    final String response = await rootBundle.loadString('assets/data/verbs.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Verb.fromJson(json)).toList();
  }
}
