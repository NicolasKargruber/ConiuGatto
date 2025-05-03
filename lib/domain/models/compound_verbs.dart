import '../../data/enums/auxiliary.dart';
import '../../data/models/tense_dto.dart';
import '../../data/models/verb_dto.dart';
import 'base_verb.dart';
import 'enums/simple_tense.dart';
import '../../data/enums/pronoun.dart';
import 'tenses/conditional_tenses.dart';
import 'tenses/indicative_tenses.dart';
import 'tenses/subjunctive_tenses.dart';

class CompoundVerbs {
  final BaseVerb essere; // Ausiliare
  final BaseVerb avere; // Ausiliare
  final BaseVerb stare; // Progressivo
  // final Verb andare; // Futuro Prossimo

  // Private Constructor
  const CompoundVerbs._({
    required this.essere,
    required this.avere,
    required this.stare,
    // required this.andare,
  });
  // Singleton instance (since these never change)
  static final instance = CompoundVerbs._(
    avere: BaseVerb(
      presentIndicative: PresentIndicative.from(conjugations:
      convertJsonToConjugations
      ({
        "io": {
          "italian": "ho",
          "english": "have"
        },
        "tu": {
          "italian": "hai",
          "english": "have"
        },
        "lui/lei": {
          "italian": "ha",
          "english": "has"
        },
        "noi": {
          "italian": "abbiamo",
          "english": "have"
        },
        "voi": {
          "italian": "avete",
          "english": "have"
        },
        "loro": {
          "italian": "hanno",
          "english": "have"
        }
      })),
      imperfectIndicative: ImperfectIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "avevo",
          "english": "used to have"
        },
        "tu": {
          "italian": "avevi",
          "english": "used to have"
        },
        "lui/lei": {
          "italian": "aveva",
          "english": "used to have"
        },
        "noi": {
          "italian": "avevamo",
          "english": "used to have"
        },
        "voi": {
          "italian": "avevate",
          "english": " used to have"
        },
        "loro": {
          "italian": "avevano",
          "english": "had"
        }
      })),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "ebbi",
          "english": "had"
        },
        "tu": {
          "italian": "avesti",
          "english": "had"
        },
        "lui/lei": {
          "italian": "ebbe",
          "english": "had"
        },
        "noi": {
          "italian": "avemmo",
          "english": "had"
        },
        "voi": {
          "italian": "aveste",
          "english": "had"
        },
        "loro": {
          "italian": "ebbero",
          "english": "had"
        }
      })),
      futureIndicative: FutureIndicative.from(conjugations: convertJsonToConjugations({
  "io": {
  "italian": "avrò",
  "english": "will have"
  },
  "tu": {
  "italian": "avrai",
  "english": "will have"
  },
  "lui/lei": {
  "italian": "avrà",
  "english": "will have"
  },
  "noi": {
  "italian": "avremo",
  "english": "will have"
  },
  "voi": {
  "italian": "avrete",
  "english": " will have"
  },
  "loro": {
  "italian": "avranno",
  "english": "will have"
  }
  })),
      presentSubjunctive: PresentSubjunctive.from(conjugations: convertJsonToConjugations({
  "io": {
  "italian": "abbia",
  "english": "have"
  },
  "tu": {
  "italian": "abbia",
  "english": "have"
  },
  "lui/lei": {
  "italian": "abbia",
  "english": "has"
  },
  "noi": {
  "italian": "abbiamo",
  "english": "have"
  },
  "voi": {
  "italian": "abbiate",
  "english": " have"
  },
  "loro": {
  "italian": "abbiano",
  "english": "have"
  }
  })),
      imperfectSubjunctive: ImperfectSubjunctive.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "avessi",
          "english": "used to have"
        },
        "tu": {
          "italian": "avessi",
          "english": "used to have"
        },
        "lui/lei": {
          "italian": "avesse",
          "english": "used to have"
        },
        "noi": {
          "italian": "avessimo",
          "english": "used to have"
        },
        "voi": {
          "italian": "aveste",
          "english": " used to have"
        },
        "loro": {
          "italian": "avessero",
          "english": "used to have"
        }
      })),
      presentConditional: PresentConditional.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "avrei",
          "english": "would have"
        },
        "tu": {
          "italian": "avresti",
          "english": "would have"
        },
        "lui/lei": {
          "italian": "avrebbe",
          "english": "would have"
        },
        "noi": {
          "italian": "avremmo",
          "english": "would have"
        },
        "voi": {
          "italian": "avreste",
          "english": "would have"
        },
        "loro": {
          "italian": "avrebbero",
          "english": "would have"
        }
      })),
    ),
    essere: BaseVerb(
      presentIndicative: PresentIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "sono",
          "english": "am"
        },
        "tu": {
          "italian": "sei",
          "english": "are"
        },
        "lui/lei": {
          "italian": "è",
          "english": "is"
        },
        "noi": {
          "italian": "siamo",
          "english": "are"
        },
        "voi": {
          "italian": "siete",
          "english": "are"
        },
        "loro": {
          "italian": "sono",
          "english": "are"
        }
      })),
      imperfectIndicative: ImperfectIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "ero",
          "english": "was"
        },
        "tu": {
          "italian": "eri",
          "english": "were"
        },
        "lui/lei": {
          "italian": "era",
          "english": "was"
        },
        "noi": {
          "italian": "eravamo",
          "english": "were"
        },
        "voi": {
          "italian": "eravate",
          "english": "were"
        },
        "loro": {
          "italian": "erano",
          "english": "were"
        }
      })),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "fui",
          "english": "was"
        },
        "tu": {
          "italian": "fosti",
          "english": "were"
        },
        "lui/lei": {
          "italian": "fu",
          "english": "was"
        },
        "noi": {
          "italian": "fummo",
          "english": "were"
        },
        "voi": {
          "italian": "foste",
          "english": "were"
        },
        "loro": {
          "italian": "furono",
          "english": "were"
        }
      })),
      futureIndicative: FutureIndicative.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "sarò",
          "english": "will be"
        },
        "tu": {
          "italian": "sarai",
          "english": "will be"
        },
        "lui/lei": {
          "italian": "sarà",
          "english": "will be"
        },
        "noi": {
          "italian": "saremo",
          "english": "will be"
        },
        "voi": {
          "italian": "sarete",
          "english": "will be"
        },
        "loro": {
          "italian": "saranno",
          "english": "will be"
        }
      })),
      presentSubjunctive: PresentSubjunctive.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "sia",
          "english": "am"
        },
        "tu": {
          "italian": "sia",
          "english": "are"
        },
        "lui/lei": {
          "italian": "sia",
          "english": "is"
        },
        "noi": {
          "italian": "siamo",
          "english": "are"
        },
        "voi": {
          "italian": "siate",
          "english": "are"
        },
        "loro": {
          "italian": "siano",
          "english": "are"
        }
      })),
      imperfectSubjunctive: ImperfectSubjunctive.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "fosse",
          "english": "was"
        },
        "tu": {
          "italian": "fossi",
          "english": "were"
        },
        "lui/lei": {
          "italian": "fosse",
          "english": "was"
        },
        "noi": {
          "italian": "fossimo",
          "english": "were"
        },
        "loro": {
          "italian": "fossero",
          "english": "were"
        }
      })),
      presentConditional: PresentConditional.from(conjugations: convertJsonToConjugations({
        "io": {
          "italian": "sarei",
          "english": "would be"
        },
        "tu": {
          "italian": "saresti",
          "english": "would be"
        },
        "lui/lei": {
          "italian": "sarebbe",
          "english": "would be"
        },
        "noi": {
          "italian": "saremmo",
          "english": "would be"
        },
        "voi": {
          "italian": "sareste",
          "english": "would be"
        },
        "loro": {
          "italian": "sarebbero",
          "english": "would be"
        }
      })),
  ),
    stare: BaseVerb(
      presentIndicative: PresentIndicative.from( conjugations: convertJsonToConjugations({
        "io": {
          "italian": "sto",
          "english": "am"
        },
        "tu": {
          "italian": "stai",
          "english": "are"
        },
        "lui/lei": {
          "italian": "sta",
          "english": "is"
        },
        "noi": {
          "italian": "stiamo",
          "english": "are"
        },
        "voi": {
          "italian": "state",
          "english": "are"
        },
        "loro": {
          "italian": "stanno",
          "english": "are"
        }
      })),
      imperfectIndicative: ImperfectIndicative.from( conjugations: convertJsonToConjugations({
        "io": {
          "italian": "stavo",
          "english": "used to be"
        },
        "tu": {
          "italian": "stavi",
          "english": "used to be"
        },
        "lui/lei": {
          "italian": "stava",
          "english": "used to be"
        },
        "noi": {
          "italian": "stavamo",
          "english": "used to be"
        },
        "voi": {
          "italian": "stavate",
          "english": "used to be"
        },
        "loro": {
          "italian": "stavano",
          "english": "used to be"
        }
      })),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from( conjugations: convertJsonToConjugations( {
        "io": {
          "italian": "stetti",
          "english": "was"
        },
        "tu": {
          "italian": "stesti",
          "english": "were"
        },
        "lui/lei": {
          "italian": "stette",
          "english": "was"
        },
        "noi": {
          "italian": "stemmo",
          "english": "were"
        },
        "voi": {
          "italian": "steste",
          "english": "were"
        },
        "loro": {
          "italian": "stettero",
          "english": "were"
        }
      })),
      futureIndicative: FutureIndicative.from( conjugations: convertJsonToConjugations( {
        "io": {
          "italian": "starò",
          "english": "will be"
        },
        "tu": {
          "italian": "starai",
          "english": "will be"
        },
        "lui/lei": {
          "italian": "starà",
          "english": "will be"
        },
        "noi": {
          "italian": "staremo",
          "english": "will be"
        },
        "voi": {
          "italian": "starete",
          "english": "will be"
        },
        "loro": {
          "italian": "staranno",
          "english": "will be"
        }
      })),
      presentSubjunctive: PresentSubjunctive.from( conjugations: convertJsonToConjugations({
        "io": {
          "italian": "stia",
          "english": "am"
        },
        "tu": {
          "italian": "stia",
          "english": "are"
        },
        "lui/lei": {
          "italian": "stia",
          "english": "is"
        },
        "noi": {
          "italian": "stiamo",
          "english": "are"
        },
        "voi": {
          "italian": "stiate",
          "english": "are"
        },
        "loro": {
          "italian": "stiano",
          "english": "are"
        }
      })),
      imperfectSubjunctive: ImperfectSubjunctive.from( conjugations: convertJsonToConjugations({
        "io": {
          "italian": "stessi",
          "english": "used to be"
        },
        "tu": {
          "italian": "stessi",
          "english": "used to be"
        },
        "lui/lei": {
          "italian": "stesse",
          "english": "used to be"
        },
        "noi": {
          "italian": "stessimo",
          "english": "used to be"
        },
        "voi": {
          "italian": "steste",
          "english": "used to be"
        },
        "loro": {
          "italian": "stessero",
          "english": "used to be"
        }
      })),
      presentConditional: PresentConditional.from( conjugations: convertJsonToConjugations({
        "io": {
          "italian": "starei",
          "english": "would be"
        },
        "tu": {
          "italian": "staresti",
          "english": "would be"
        },
        "lui/lei": {
          "italian": "starebbe",
          "english": "would be"
        },
        "noi": {
          "italian": "staremmo",
          "english": "would be"
        },
        "voi": {
          "italian": "stareste",
          "english": "would be"
        },
        "loro": {
          "italian": "starebbero",
          "english": "would be"
        }
      })),
    ),
  );

  String? conjugateItalianAuxiliary(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final verb = switch (auxiliary) {
      Auxiliary.avere => avere,
      Auxiliary.essere => essere,
    };

    return switch (tense) {
      SimpleTense.presentIndicative => verb.presentIndicative[pronoun]?.italian,
      SimpleTense.imperfectIndicative => verb.imperfectIndicative[pronoun]?.italian,
      SimpleTense.futureIndicative => verb.futureIndicative[pronoun]?.italian,
      SimpleTense.historicalPresentPerfectIndicative => verb.historicalPresentPerfectIndicative[pronoun]?.italian,
      SimpleTense.presentSubjunctive => verb.presentSubjunctive[pronoun]?.italian,
      SimpleTense.imperfectSubjunctive => verb.imperfectSubjunctive[pronoun]?.italian,
      SimpleTense.presentConditional => verb.presentConditional[pronoun]?.italian,
    };
  }

  String? conjugateEnglishAuxiliary(Pronoun pronoun, SimpleTense tense) {
    return switch (tense) {
      SimpleTense.presentIndicative => avere.presentIndicative[pronoun]?.english,
      SimpleTense.imperfectIndicative => avere.historicalPresentPerfectIndicative[pronoun]?.english,
      SimpleTense.futureIndicative => "will have",
      SimpleTense.historicalPresentPerfectIndicative => avere.historicalPresentPerfectIndicative[pronoun]?.english,
      SimpleTense.presentSubjunctive => avere.presentSubjunctive[pronoun]?.english,
      SimpleTense.imperfectSubjunctive => avere.historicalPresentPerfectIndicative[pronoun]?.english,
      SimpleTense.presentConditional => avere.presentConditional[pronoun]?.english,
    };
  }

  String? conjugateStare(Pronoun pronoun, {SimpleTense tense = SimpleTense.presentIndicative}) =>
      stare.presentIndicative[pronoun]?.italian;

  String? conjugateStareInEnglish(Pronoun pronoun, {SimpleTense tense = SimpleTense.presentIndicative}) =>
      stare.presentIndicative[pronoun]?.english;

  // TODO Remove in Future
  static Conjugations convertJsonToConjugations(Map<String, dynamic> json) {
    mapToConjugations(Pronoun pronoun) => Conjugation(pronoun, conjugatedVerbOrNullFrom(json[pronoun.jsonKey]));
    return Conjugations.fromEntries(Pronoun.values.map(mapToConjugations));
  }
}