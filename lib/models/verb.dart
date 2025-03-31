import 'dart:convert';

import 'package:coniugatto/models/moods/moods.dart';
import 'package:flutter/services.dart' show rootBundle;

class Verb {
  final String infinitive;
  final String translation;
  final Regularity regularity;
  final List<Auxiliary> auxiliaries;
  final Moods moods;
  final String pastParticiple;
  final String presentGerund;

  Verb({
    required this.infinitive,
    required this.translation,
    required this.regularity,
    required this.auxiliaries,
    required this.moods,
    required this.pastParticiple,
    required this.presentGerund,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: json['infinitive'],
      translation: json['translation'],
      regularity: Regularity.fromJson(json['type']),
      auxiliaries: (json['auxiliary'] as List)
          .map((e) => Auxiliary.fromJson(e)).toList(),
      moods: Moods.fromJson(json['conjugations']),
      pastParticiple: json['participio_passato'],
      presentGerund: json['gerundio_presente'],
    );
  }
}

enum Regularity { regular('regular'), irregular('irregular');
  
  final String jsonKey;
  const Regularity(this.jsonKey);

  factory Regularity.fromJson(dynamic json)
  => Regularity.values.firstWhere((e) => e.jsonKey == json);
}

enum Auxiliary { toHave('avere'), toBe('essere');


  final String jsonKey;
  const Auxiliary(this.jsonKey);

  factory Auxiliary.fromJson(dynamic json)
  => Auxiliary.values.firstWhere((e) => e.jsonKey == json);
}

Future<List<Verb>> loadVerbs() async {
  final String response = await rootBundle.loadString('assets/data/verbs.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Verb.fromJson(json)).toList();
}
