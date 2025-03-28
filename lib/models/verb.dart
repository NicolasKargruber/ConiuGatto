import 'dart:convert';

import 'package:coniugatto/models/moods/moods.dart';
import 'package:flutter/services.dart' show rootBundle;

class Verb {
  final String infinitive;
  final String translation;
  final VerbType type;
  final List<Auxiliary> auxiliaries;
  final Moods moods;
  final String pastParticiple;
  final String presentGerund;

  Verb({
    required this.infinitive,
    required this.translation,
    required this.type,
    required this.auxiliaries,
    required this.moods,
    required this.pastParticiple,
    required this.presentGerund,
  });

  factory Verb.fromJson(Map<String, dynamic> json) {
    return Verb(
      infinitive: json['infinitive'],
      translation: json['translation'],
      type: VerbType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => VerbType.regular,
      ),
      auxiliaries: (json['auxiliary'] as List)
          .map((e) =>
          Auxiliary.values.firstWhere(
                (a) => a.name == e,
            orElse: () => Auxiliary.have,
          ))
          .toList(),
      moods: Moods.fromJson(json['conjugations']),
      pastParticiple: json['participio_passato'],
      presentGerund: json['gerundio_presente'],
    );
  }
}

enum VerbType { regular, irregular }

enum Auxiliary { have, be }

Future<List<Verb>> loadVerbs() async {
  final String response = await rootBundle.loadString('assets/data/verbs.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => Verb.fromJson(json)).toList();
}
