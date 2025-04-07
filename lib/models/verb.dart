import 'auxiliary.dart';
import 'moods/moods.dart';
import 'regularity.dart';

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
      regularity: Regularity.fromJson(json['regularity']),
      auxiliaries: (json['auxiliaries'] as List).map((e) => Auxiliary.fromJson(e)).toList(),
      moods: Moods.fromJson(json['conjugations']),
      pastParticiple: json['participio_passato'],
      presentGerund: json['gerundio_presente'],
    );
  }
}
