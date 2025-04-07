import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Verb {
  final String infinitive;
  final String translation;
  final Map<String, dynamic> conjugations;

  Verb({
    required this.infinitive,
    required this.translation,
    required this.conjugations,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: json['infinitive'],
      translation: json['translation'],
      conjugations: json['conjugations'],
    );
  }
}

Future<List<Verb>> loadVerbs() async {
  final String response = await rootBundle.loadString('assets/data/verbs.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Verb.fromJson(json)).toList();
}
