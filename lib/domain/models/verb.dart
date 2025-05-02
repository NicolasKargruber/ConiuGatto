import 'package:collection/collection.dart';

import '../../data/enums/auxiliary.dart';
import '../../data/enums/irregularity.dart';
import 'enums/italian_tense.dart';
import '../../data/enums/regularity.dart';
import '../../data/models/verb_dto.dart';
import '../utils/verb_extensions.dart';
import 'base_verb.dart';
import 'tenses/conditional_tenses.dart';
import 'tenses/imperative_tenses.dart';
import 'tenses/indicative_tenses.dart';
import 'tenses/subjunctive_tenses.dart';
import 'tenses/tense.dart';

typedef ConjugatedVerb = ({String italian, String english});

class Verb extends BaseVerb {
  final ConjugatedVerb infinitive;
  final Regularity regularity;
  final Set<Irregularity> irregularities;
  final List<Auxiliary> auxiliaries;
  final ConjugatedVerb pastParticiple;
  final ConjugatedVerb presentGerund;

  Verb._({
    required this.infinitive,
    required this.regularity,
    required this.irregularities,
    required this.auxiliaries,
    required super.presentIndicative,
    required super.imperfectIndicative,
    required super.historicalPresentPerfectIndicative,
    required super.futureIndicative,
    required super.presentSubjunctive,
    required super.imperfectSubjunctive,
    required super.presentConditional,
    required super.positiveImperative,
    required this.pastParticiple,
    required this.presentGerund,
  });

  factory Verb.fromDTO(VerbDTO dto) {
    return Verb._(
      infinitive: dto.infinitive,
      regularity: dto.regularity,
      irregularities: dto.irregularities,
      auxiliaries: dto.auxiliaries,
      presentIndicative: PresentIndicative(conjugations: dto.presentIndicative.conjugations),
      imperfectIndicative: ImperfectIndicative(conjugations: dto.imperfectIndicative.conjugations),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative(conjugations: dto.historicalPresentPerfectIndicative.conjugations),
      futureIndicative: FutureIndicative(conjugations: dto.futureIndicative.conjugations),
      presentSubjunctive: PresentSubjunctive(conjugations: dto.presentSubjunctive.conjugations),
      imperfectSubjunctive: ImperfectSubjunctive(conjugations: dto.imperfectSubjunctive.conjugations),
      presentConditional: PresentConditional(conjugations: dto.presentConditional.conjugations),
      positiveImperative: PositiveImperative(conjugations: dto.positiveImperative.conjugations),
      pastParticiple: dto.pastParticiple,
      presentGerund: dto.presentGerund,
    );
  }

  /// Used for Shared Preferences
  String get prefKey => italianInfinitive;

  // Getters - Helpers
  String get stem => italianInfinitive.substring(0, italianInfinitive.length - 3); // ex. 'parl'
  String get ending => italianInfinitive.substring(italianInfinitive.length - 3).toUpperCase(); // ARE, ERE, IRE
  String get italianInfinitive => infinitive.italian;
  String get translation => infinitive.english;
  bool get isRegular => regularity.isRegular;
  bool get isDoubleAuxiliary => UnorderedIterableEquality().equals(Auxiliary.values, auxiliaries);

  // Helpers
  Tense Function(Auxiliary) getTense(ItalianTense tense) {
    return switch(tense) {
      ItalianTense.presentIndicative => (_) => presentIndicative,
      ItalianTense.presentContinuousIndicative => (_) => presentContinuousIndicative,
      ItalianTense.imperfectIndicative => (_) => imperfectIndicative,
      ItalianTense.presentPerfectIndicative => presentPerfectIndicative,
      ItalianTense.pastPerfectIndicative => pastPerfectIndicative,
      ItalianTense.historicalPresentPerfectIndicative => (_) => historicalPresentPerfectIndicative,
      ItalianTense.historicalPastPerfectIndicative => historicalPastPerfectIndicative,
      ItalianTense.futureIndicative => (_) => futureIndicative,
      ItalianTense.futurePerfectIndicative => futurePerfectIndicative,
      ItalianTense.presentSubjunctive => (_) => presentSubjunctive,
      ItalianTense.imperfectSubjunctive => (_) => imperfectSubjunctive,
      ItalianTense.presentPerfectSubjunctive => presentPerfectSubjunctive,
      ItalianTense.pastPerfectSubjunctive => pastPerfectSubjunctive,
      ItalianTense.presentConditional => (_) => presentConditional,
      ItalianTense.presentPerfectConditional => presentPerfectConditional,
      ItalianTense.positiveImperative => (_) => positiveImperative,
      ItalianTense.negativeImperative => (_) => negativeImperative,
    };
  }
}
