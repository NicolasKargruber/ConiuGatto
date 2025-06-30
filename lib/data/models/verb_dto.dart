import '../enums/german_auxiliary.dart';
import '../enums/italian_auxiliary.dart';
import '../enums/irregularity.dart';
import '../enums/pronoun.dart';
import '../enums/regularity.dart';
import 'tense_dto.dart';

// typedefs - Conjugations
typedef TranslatedConjugation = ({String italian, String english, String german});
typedef Conjugations = Map<Pronoun, TranslatedConjugation?>;
// fromJson()
TranslatedConjugation translatedConjugationFrom(dynamic json)
=> (italian: json['italian'], english: json['english'], german: json['german']);

class VerbDTO {
  final String id;
  final TranslatedConjugation infinitive;
  final Regularity regularity;
  final Set<Irregularity> irregularities;
  final List<ItalianAuxiliary> auxiliaries;
  final GermanAuxiliary germanAuxiliary;
  final TranslatedConjugation pastParticiple;
  final TranslatedConjugation presentGerund;

  // INDICATIVE => START
  /// => Indicativo Presente
  final TenseDTO presentIndicative;
  /// => Indicativo Imperfecto
  final TenseDTO imperfectIndicative;
  /// => Indicativo Passato Remoto
  final TenseDTO historicalPresentPerfectIndicative;
  /// => Indicativo Futuro Semplice
  final TenseDTO futureIndicative;
  // INDICATIVE <= END

  // SUBJUNCTIVE => START
  /// => Congiuntivo Presente
  final TenseDTO presentSubjunctive;
  /// => Congiuntivo Imperfetto
  final TenseDTO imperfectSubjunctive;
  // SUBJUNCTIVE <= END

  // CONDITIONAL => START
  /// Condizionale Presente
  final TenseDTO presentConditional;
  // CONDITIONAL <= END

  // IMPERATIVE => START
  /// => Imperativo Positivo
  final TenseDTO positiveImperative;
  // IMPERATIVE <= END

  VerbDTO._({
    required this.id,
    required this.infinitive,
    required this.regularity,
    required this.irregularities,
    required this.auxiliaries,
    required this.germanAuxiliary,
    required this.presentIndicative,
    required this.imperfectIndicative,
    required this.historicalPresentPerfectIndicative,
    required this.futureIndicative,
    required this.presentSubjunctive,
    required this.imperfectSubjunctive,
    required this.presentConditional,
    required this.positiveImperative,
    required this.pastParticiple,
    required this.presentGerund,
  });

  factory VerbDTO.fromJson(Map<String, dynamic> json) {
    return VerbDTO._(
      id: json['id'],
      infinitive: translatedConjugationFrom(json['infinitive']),
      regularity: Regularity.fromJson(json['regularity']),
      irregularities: (json['irregularities'] as List? ?? []).map((e) => Irregularity.fromJson(e)).toSet(),
      auxiliaries: (json['auxiliaries'] as List).map((e) => ItalianAuxiliary.fromJson(e)).toList(),
      germanAuxiliary: GermanAuxiliary.fromJson(json['german_auxiliary']),
      presentIndicative: TenseDTO.fromJson(json['conjugations']['indicativo']['presente']),
      imperfectIndicative: TenseDTO.fromJson(json['conjugations']['indicativo']['imperfetto']),
      historicalPresentPerfectIndicative: TenseDTO.fromJson(json['conjugations']['indicativo']['passato_remoto']),
      futureIndicative: TenseDTO.fromJson(json['conjugations']['indicativo']['futuro_semplice']),
      presentSubjunctive: TenseDTO.fromJson(json['conjugations']['congiuntivo']['presente']),
      imperfectSubjunctive: TenseDTO.fromJson(json['conjugations']['congiuntivo']['imperfetto']),
      presentConditional: TenseDTO.fromJson(json['conjugations']['condizionale']['presente']),
      positiveImperative: TenseDTO.fromJson(json['conjugations']['imperativo']['positivo']),
      pastParticiple: translatedConjugationFrom(json['participio_passato']),
      presentGerund: translatedConjugationFrom(json['gerundio_presente']),
    );
  }
}
