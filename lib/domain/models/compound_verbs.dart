import '../../data/enums/german_auxiliary.dart';
import '../../data/enums/italian_auxiliary.dart';
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
      presentIndicative: PresentIndicative.from(conjugations: convertJsonToConjugations(_avere["indicativo"]!["presente"]!)),
      imperfectIndicative: ImperfectIndicative.from(conjugations: convertJsonToConjugations(_avere["indicativo"]!["imperfetto"]!)),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from(conjugations: convertJsonToConjugations(_avere["indicativo"]!["passato_remoto"]!)),
      futureIndicative: FutureIndicative.from(conjugations: convertJsonToConjugations(_avere["indicativo"]!["futuro_semplice"]!)),
      presentSubjunctive: PresentSubjunctive.from(conjugations: convertJsonToConjugations(_avere["congiuntivo"]!["presente"]!)),
      imperfectSubjunctive: ImperfectSubjunctive.from(conjugations: convertJsonToConjugations(_avere["congiuntivo"]!["imperfetto"]!)),
      presentConditional: PresentConditional.from(conjugations: convertJsonToConjugations(_avere["condizionale"]!["presente"]!)),
    ),
    essere: BaseVerb(
      presentIndicative: PresentIndicative.from(conjugations: convertJsonToConjugations(_essere["indicativo"]!["presente"]!)),
      imperfectIndicative: ImperfectIndicative.from(conjugations: convertJsonToConjugations(_essere["indicativo"]!["imperfetto"]!)),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from(conjugations: convertJsonToConjugations(_essere["indicativo"]!["passato_remoto"]!)),
      futureIndicative: FutureIndicative.from(conjugations: convertJsonToConjugations(_essere["indicativo"]!["futuro_semplice"]!)),
      presentSubjunctive: PresentSubjunctive.from(conjugations: convertJsonToConjugations(_essere["congiuntivo"]!["presente"]!)),
      imperfectSubjunctive: ImperfectSubjunctive.from(conjugations: convertJsonToConjugations(_essere["congiuntivo"]!["imperfetto"]!)),
      presentConditional: PresentConditional.from(conjugations: convertJsonToConjugations(_essere["condizionale"]!["presente"]!)),
    ),
    stare: BaseVerb(
      presentIndicative: PresentIndicative.from(conjugations: convertJsonToConjugations(_stare["indicativo"]!["presente"]!)),
      imperfectIndicative: ImperfectIndicative.from(conjugations: convertJsonToConjugations(_stare["indicativo"]!["imperfetto"]!)),
      historicalPresentPerfectIndicative: HistoricalPresentPerfectIndicative.from(conjugations: convertJsonToConjugations(_stare["indicativo"]!["passato_remoto"]!)),
      futureIndicative: FutureIndicative.from(conjugations: convertJsonToConjugations(_stare["indicativo"]!["futuro_semplice"]!)),
      presentSubjunctive: PresentSubjunctive.from(conjugations: convertJsonToConjugations(_stare["congiuntivo"]!["presente"]!)),
      imperfectSubjunctive: ImperfectSubjunctive.from(conjugations: convertJsonToConjugations(_stare["congiuntivo"]!["imperfetto"]!)),
      presentConditional: PresentConditional.from(conjugations: convertJsonToConjugations(_stare["condizionale"]!["presente"]!)),
    ),
  );

  String? conjugateItalianAuxiliary(Pronoun pronoun, ItalianAuxiliary auxiliary, SimpleTense tense) {
    final verb = switch (auxiliary) {
      ItalianAuxiliary.avere => avere,
      ItalianAuxiliary.essere => essere,
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

  String? conjugateGermanAuxiliary(Pronoun pronoun, GermanAuxiliary auxiliary, SimpleTense tense) {
    final verb = switch (auxiliary) {
      GermanAuxiliary.haben => avere,
      GermanAuxiliary.sein => essere,
    };

    return switch (tense) {
      SimpleTense.presentIndicative => verb.presentIndicative[pronoun]?.german,
      SimpleTense.imperfectIndicative => verb.imperfectIndicative[pronoun]?.german,
      SimpleTense.futureIndicative => verb.futureIndicative[pronoun]?.german,
      SimpleTense.historicalPresentPerfectIndicative => verb.historicalPresentPerfectIndicative[pronoun]?.german,
      SimpleTense.presentSubjunctive => verb.presentSubjunctive[pronoun]?.german,
      SimpleTense.imperfectSubjunctive => verb.imperfectSubjunctive[pronoun]?.german,
      SimpleTense.presentConditional => verb.presentConditional[pronoun]?.german,
    };
  }

  String? conjugateGerman(Pronoun pronoun, GermanAuxiliary auxiliary, SimpleTense tense, String pastParticiple) {
    final verb = switch (auxiliary) {
      GermanAuxiliary.haben => avere,
      GermanAuxiliary.sein => essere,
    };

    switch (tense) {
      case SimpleTense.presentIndicative:
        return "${verb.presentIndicative[pronoun]?.german} $pastParticiple";
      case SimpleTense.imperfectIndicative:
        return "${verb.imperfectIndicative[pronoun]?.german} $pastParticiple";
      case SimpleTense.futureIndicative:
        final futureSplit = verb.futureIndicative[pronoun]?.german.split(" ");
        return "${futureSplit?[0]} $pastParticiple ${futureSplit?[1]}";
      case SimpleTense.historicalPresentPerfectIndicative:
        return "${verb.historicalPresentPerfectIndicative[pronoun]?.german} $pastParticiple";
      case SimpleTense.presentSubjunctive:
        return "${verb.presentSubjunctive[pronoun]?.german} $pastParticiple";
      case SimpleTense.imperfectSubjunctive:
        return "${verb.imperfectSubjunctive[pronoun]?.german} $pastParticiple";
      case SimpleTense.presentConditional:
        final conditionalSplit = verb.presentConditional[pronoun]?.german.split(" ");
        return "${conditionalSplit?[0]} $pastParticiple ${conditionalSplit?[1]}";
    }
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

final _avere =  {
  "indicativo": {
    "presente": {
      "io": {
        "italian": "ho",
        "english": "have",
        "german": "habe",
        "spanish": "he"
      },
      "tu": {
        "italian": "hai",
        "english": "have",
        "german": "hast",
        "spanish": "has"
      },
      "lui/lei": {
        "italian": "ha",
        "english": "has",
        "german": "hat",
        "spanish": "ha"
      },
      "noi": {
        "italian": "abbiamo",
        "english": "have",
        "german": "haben",
        "spanish": "hemos"
      },
      "voi": {
        "italian": "avete",
        "english": "have",
        "german": "habt",
        "spanish": "habéis"
      },
      "loro": {
        "italian": "hanno",
        "english": "have",
        "german": "haben",
        "spanish": "han"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "avevo",
        "english": "used to have",
        "german": "hatte",
        "spanish": "había"
      },
      "tu": {
        "italian": "avevi",
        "english": "used to have",
        "german": "hattest",
        "spanish": "habías"
      },
      "lui/lei": {
        "italian": "aveva",
        "english": "used to have",
        "german": "hatte",
        "spanish": "había"
      },
      "noi": {
        "italian": "avevamo",
        "english": "used to have",
        "german": "hatten",
        "spanish": "habíamos"
      },
      "voi": {
        "italian": "avevate",
        "english": "used to have",
        "german": "hattet",
        "spanish": "habíais"
      },
      "loro": {
        "italian": "avevano",
        "english": "had",
        "german": "hatten",
        "spanish": "habían"
      }
    },
    "passato_remoto": {
      "io": {
        "italian": "ebbi",
        "english": "had",
        "german": "hatte",
        "spanish": "hube"
      },
      "tu": {
        "italian": "avesti",
        "english": "had",
        "german": "hattest",
        "spanish": "hubiste"
      },
      "lui/lei": {
        "italian": "ebbe",
        "english": "had",
        "german": "hatte",
        "spanish": "hubo"
      },
      "noi": {
        "italian": "avemmo",
        "english": "had",
        "german": "hatten",
        "spanish": "hubimos"
      },
      "voi": {
        "italian": "aveste",
        "english": "had",
        "german": "hattet",
        "spanish": "hubisteis"
      },
      "loro": {
        "italian": "ebbero",
        "english": "had",
        "german": "hatten",
        "spanish": "hubieron"
      }
    },
    "futuro_semplice": {
      "io": {
        "italian": "avrò",
        "english": "will have",
        "german": "werde haben",
        "spanish": "habré"
      },
      "tu": {
        "italian": "avrai",
        "english": "will have",
        "german": "wirst haben",
        "spanish": "habrás"
      },
      "lui/lei": {
        "italian": "avrà",
        "english": "will have",
        "german": "wird haben",
        "spanish": "habrá"
      },
      "noi": {
        "italian": "avremo",
        "english": "will have",
        "german": "werden haben",
        "spanish": "habremos"
      },
      "voi": {
        "italian": "avrete",
        "english": "will have",
        "german": "werdet haben",
        "spanish": "habréis"
      },
      "loro": {
        "italian": "avranno",
        "english": "will have",
        "german": "werden haben",
        "spanish": "habrán"
      }
    }
  },
  "congiuntivo": {
    "presente": {
      "io": {
        "italian": "abbia",
        "english": "have",
        "german": "habe",
        "spanish": "haya"
      },
      "tu": {
        "italian": "abbia",
        "english": "have",
        "german": "habest",
        "spanish": "hayas"
      },
      "lui/lei": {
        "italian": "abbia",
        "english": "has",
        "german": "habe",
        "spanish": "haya"
      },
      "noi": {
        "italian": "abbiamo",
        "english": "have",
        "german": "haben",
        "spanish": "hayamos"
      },
      "voi": {
        "italian": "abbiate",
        "english": "have",
        "german": "habet",
        "spanish": "hayáis"
      },
      "loro": {
        "italian": "abbiano",
        "english": "have",
        "german": "haben",
        "spanish": "hayan"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "avessi",
        "english": "used to have",
        "german": "hätte",
        "spanish": "hubiera"
      },
      "tu": {
        "italian": "avessi",
        "english": "used to have",
        "german": "hättest",
        "spanish": "hubieras"
      },
      "lui/lei": {
        "italian": "avesse",
        "english": "used to have",
        "german": "hätte",
        "spanish": "hubiera"
      },
      "noi": {
        "italian": "avessimo",
        "english": "used to have",
        "german": "hätten",
        "spanish": "hubiéramos"
      },
      "voi": {
        "italian": "aveste",
        "english": "used to have",
        "german": "hättet",
        "spanish": "hubierais"
      },
      "loro": {
        "italian": "avessero",
        "english": "used to have",
        "german": "hätten",
        "spanish": "hubieran"
      }
    }
  },
  "condizionale": {
    "presente": {
      "io": {
        "italian": "avrei",
        "english": "would have",
        "german": "würde haben",
        "spanish": "habría"
      },
      "tu": {
        "italian": "avresti",
        "english": "would have",
        "german": "würdest haben",
        "spanish": "habrías"
      },
      "lui/lei": {
        "italian": "avrebbe",
        "english": "would have",
        "german": "würde haben",
        "spanish": "habría"
      },
      "noi": {
        "italian": "avremmo",
        "english": "would have",
        "german": "würden haben",
        "spanish": "habríamos"
      },
      "voi": {
        "italian": "avreste",
        "english": "would have",
        "german": "würdet haben",
        "spanish": "habríais"
      },
      "loro": {
        "italian": "avrebbero",
        "english": "would have",
        "german": "würden haben",
        "spanish": "habrían"
      }
    }
  },
  "imperativo": {
    "positivo": {
      "io": null,
      "tu": {
        "italian": "abbi",
        "english": "have!",
        "german": "habe!",
        "spanish": "¡he!"
      },
      "lui/lei": {
        "italian": "abbia",
        "english": "have!",
        "german": "habe!",
        "spanish": "¡haya!"
      },
      "noi": {
        "italian": "abbiamo",
        "english": "let's have!",
        "german": "haben wir!",
        "spanish": "¡hayamos!"
      },
      "voi": {
        "italian": "abbiate",
        "english": "(to you plural) have!",
        "german": "habt!",
        "spanish": "¡habed!"
      },
      "loro": {
        "italian": "abbiano",
        "english": "have!",
        "german": "haben Sie!",
        "spanish": "¡hayan!"
      }
    }
  }
};
final _essere =  {
  "indicativo": {
    "presente": {
      "io": {
        "italian": "sono",
        "english": "am",
        "german": "bin",
        "spanish": "soy"
      },
      "tu": {
        "italian": "sei",
        "english": "are",
        "german": "bist",
        "spanish": "eres"
      },
      "lui/lei": {
        "italian": "è",
        "english": "is",
        "german": "es",
        "spanish": "es"
      },
      "noi": {
        "italian": "siamo",
        "english": "are",
        "german": "sind",
        "spanish": "somos"
      },
      "voi": {
        "italian": "siete",
        "english": "are",
        "german": "seid",
        "spanish": "sois"
      },
      "loro": {
        "italian": "sono",
        "english": "are",
        "german": "sind",
        "spanish": "son"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "ero",
        "english": "used to be",
        "german": "war",
        "spanish": "era"
      },
      "tu": {
        "italian": "eri",
        "english": "used to be",
        "german": "warst",
        "spanish": "eras"
      },
      "lui/lei": {
        "italian": "era",
        "english": "used to be",
        "german": "war",
        "spanish": "era"
      },
      "noi": {
        "italian": "eravamo",
        "english": "used to be",
        "german": "waren",
        "spanish": "éramos"
      },
      "voi": {
        "italian": "eravate",
        "english": "used to be",
        "german": "wart",
        "spanish": "erais"
      },
      "loro": {
        "italian": "erano",
        "english": "used to be",
        "german": "waren",
        "spanish": "eran"
      }
    },
    "passato_remoto": {
      "io": {
        "italian": "fui",
        "english": "was",
        "german": "war",
        "spanish": "fui"
      },
      "tu": {
        "italian": "fosti",
        "english": "were",
        "german": "warst",
        "spanish": "fuiste"
      },
      "lui/lei": {
        "italian": "fu",
        "english": "was",
        "german": "war",
        "spanish": "fue"
      },
      "noi": {
        "italian": "fummo",
        "english": "were",
        "german": "waren",
        "spanish": "fuimos"
      },
      "voi": {
        "italian": "foste",
        "english": "were",
        "german": "wart",
        "spanish": "fuisteis"
      },
      "loro": {
        "italian": "furono",
        "english": "were",
        "german": "waren",
        "spanish": "fueron"
      }
    },
    "futuro_semplice": {
      "io": {
        "italian": "sarò",
        "english": "will be",
        "german": "werde sein",
        "spanish": "seré"
      },
      "tu": {
        "italian": "sarai",
        "english": "will be",
        "german": "wirst sein",
        "spanish": "serás"
      },
      "lui/lei": {
        "italian": "sarà",
        "english": "will be",
        "german": "wird sein",
        "spanish": "será"
      },
      "noi": {
        "italian": "saremo",
        "english": "will be",
        "german": "werden sein",
        "spanish": "seremos"
      },
      "voi": {
        "italian": "sarete",
        "english": "will be",
        "german": "werdet sein",
        "spanish": "seréis"
      },
      "loro": {
        "italian": "saranno",
        "english": "will be",
        "german": "werden sein",
        "spanish": "serán"
      }
    }
  },
  "congiuntivo": {
    "presente": {
      "io": {
        "italian": "sia",
        "english": "am",
        "german": "sei",
        "spanish": "sea"
      },
      "tu": {
        "italian": "sia",
        "english": "are",
        "german": "seiest",
        "spanish": "seas"
      },
      "lui/lei": {
        "italian": "sia",
        "english": "is",
        "german": "sei",
        "spanish": "sea"
      },
      "noi": {
        "italian": "siamo",
        "english": "are",
        "german": "seien",
        "spanish": "seamos"
      },
      "voi": {
        "italian": "siate",
        "english": "are",
        "german": "seiet",
        "spanish": "seáis"
      },
      "loro": {
        "italian": "siano",
        "english": "are",
        "german": "seien",
        "spanish": "sean"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "fossi",
        "english": "used to be",
        "german": "wäre",
        "spanish": "fuera"
      },
      "tu": {
        "italian": "fossi",
        "english": "used to be",
        "german": "wärst",
        "spanish": "fueras"
      },
      "lui/lei": {
        "italian": "fosse",
        "english": "used to be",
        "german": "wärt",
        "spanish": "fuera"
      },
      "noi": {
        "italian": "fossimo",
        "english": "used to be",
        "german": "wären",
        "spanish": "fuéramos"
      },
      "voi": {
        "italian": "foste",
        "english": "used to be",
        "german": "wärt",
        "spanish": "fuerais"
      },
      "loro": {
        "italian": "fossero",
        "english": "used to be",
        "german": "wären",
        "spanish": "fueran"
      }
    }
  },
  "condizionale": {
    "presente": {
      "io": {
        "italian": "sarei",
        "english": "would be",
        "german": "würde sein",
        "spanish": "sería"
      },
      "tu": {
        "italian": "saresti",
        "english": "would be",
        "german": "würdest sein",
        "spanish": "serías"
      },
      "lui/lei": {
        "italian": "sarebbe",
        "english": "would be",
        "german": "würde sein",
        "spanish": "sería"
      },
      "noi": {
        "italian": "saremmo",
        "english": "would be",
        "german": "würden sein",
        "spanish": "seríamos"
      },
      "voi": {
        "italian": "sareste",
        "english": "would be",
        "german": "würdet sein",
        "spanish": "seríais"
      },
      "loro": {
        "italian": "sarebbero",
        "english": "would be",
        "german": "würden sein",
        "spanish": "serían"
      }
    }
  },
  "imperativo": {
    "positivo": {
      "io": null,
      "tu": {
        "italian": "sii",
        "english": "be!",
        "german": "sei!",
        "spanish": "sé!"
      },
      "lui/lei": {
        "italian": "sia",
        "english": "be!",
        "german": "sei!",
        "spanish": "sea!"
      },
      "noi": {
        "italian": "siamo",
        "english": "let's be!",
        "german": "seien wir!",
        "spanish": "seamos!"
      },
      "voi": {
        "italian": "siate",
        "english": "(to you plural) be!",
        "german": "seid!",
        "spanish": "sed!"
      },
      "loro": {
        "italian": "siano",
        "english": "be!",
        "german": "seien Sie!",
        "spanish": "sean!"
      }
    }
  }
};
final _stare =  {
  "indicativo": {
    "presente": {
      "io": {
        "italian": "sto",
        "english": "am",
        "german": "bin",
        "spanish": "estoy"
      },
      "tu": {
        "italian": "stai",
        "english": "are",
        "german": "bist",
        "spanish": "estás"
      },
      "lui/lei": {
        "italian": "sta",
        "english": "is",
        "german": "ist",
        "spanish": "está"
      },
      "noi": {
        "italian": "stiamo",
        "english": "are",
        "german": "sind",
        "spanish": "estamos"
      },
      "voi": {
        "italian": "state",
        "english": "are",
        "german": "seid",
        "spanish": "estáis"
      },
      "loro": {
        "italian": "stanno",
        "english": "are",
        "german": "sind",
        "spanish": "están"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "stavo",
        "english": "used to be",
        "german": "war",
        "spanish": "estaba"
      },
      "tu": {
        "italian": "stavi",
        "english": "used to be",
        "german": "warst",
        "spanish": "estabas"
      },
      "lui/lei": {
        "italian": "stava",
        "english": "used to be",
        "german": "war",
        "spanish": "estaba"
      },
      "noi": {
        "italian": "stavamo",
        "english": "used to be",
        "german": "waren",
        "spanish": "estábamos"
      },
      "voi": {
        "italian": "stavate",
        "english": "used to be",
        "german": "wart",
        "spanish": "estabais"
      },
      "loro": {
        "italian": "stavano",
        "english": "used to be",
        "german": "waren",
        "spanish": "estaban"
      }
    },
    "passato_remoto": {
      "io": {
        "italian": "stetti",
        "english": "was",
        "german": "war",
        "spanish": "estuve"
      },
      "tu": {
        "italian": "stesti",
        "english": "were",
        "german": "warst",
        "spanish": "estuviste"
      },
      "lui/lei": {
        "italian": "stette",
        "english": "was",
        "german": "war",
        "spanish": "estuvo"
      },
      "noi": {
        "italian": "stemmo",
        "english": "were",
        "german": "waren",
        "spanish": "estuvimos"
      },
      "voi": {
        "italian": "steste",
        "english": "were",
        "german": "wart",
        "spanish": "estuvisteis"
      },
      "loro": {
        "italian": "stettero",
        "english": "were",
        "german": "waren",
        "spanish": "estuvieron"
      }
    },
    "futuro_semplice": {
      "io": {
        "italian": "starò",
        "english": "will be",
        "german": "werde sein",
        "spanish": "estaré"
      },
      "tu": {
        "italian": "starai",
        "english": "will be",
        "german": "wirst sein",
        "spanish": "estarás"
      },
      "lui/lei": {
        "italian": "starà",
        "english": "will be",
        "german": "wird sein",
        "spanish": "estará"
      },
      "noi": {
        "italian": "staremo",
        "english": "will be",
        "german": "werden sein",
        "spanish": "estaremos"
      },
      "voi": {
        "italian": "starete",
        "english": "will be",
        "german": "werdet sein",
        "spanish": "estaréis"
      },
      "loro": {
        "italian": "staranno",
        "english": "will be",
        "german": "werden sein",
        "spanish": "estarán"
      }
    }
  },
  "congiuntivo": {
    "presente": {
      "io": {
        "italian": "stia",
        "english": "am",
        "german": "sei",
        "spanish": "esté"
      },
      "tu": {
        "italian": "stia",
        "english": "are",
        "german": "seiest",
        "spanish": "estés"
      },
      "lui/lei": {
        "italian": "stia",
        "english": "is",
        "german": "sei",
        "spanish": "esté"
      },
      "noi": {
        "italian": "stiamo",
        "english": "are",
        "german": "seien",
        "spanish": "estemos"
      },
      "voi": {
        "italian": "stiate",
        "english": "are",
        "german": "seiet",
        "spanish": "estéis"
      },
      "loro": {
        "italian": "stiano",
        "english": "are",
        "german": "seien",
        "spanish": "estén"
      }
    },
    "imperfetto": {
      "io": {
        "italian": "stessi",
        "english": "were",
        "german": "wäre",
        "spanish": "estuviera"
      },
      "tu": {
        "italian": "stessi",
        "english": "were",
        "german": "wärest",
        "spanish": "estuvieras"
      },
      "lui/lei": {
        "italian": "stesse",
        "english": "were",
        "german": "wäre",
        "spanish": "estuviera"
      },
      "noi": {
        "italian": "stessimo",
        "english": "were",
        "german": "wären",
        "spanish": "estuviéramos"
      },
      "voi": {
        "italian": "steste",
        "english": "were",
        "german": "wäret",
        "spanish": "estuvierais"
      },
      "loro": {
        "italian": "stessero",
        "english": "were",
        "german": "wären",
        "spanish": "estuvieran"
      }
    }
  },
  "condizionale": {
    "presente": {
      "io": {
        "italian": "starei",
        "english": "would be",
        "german": "würde sein",
        "spanish": "estaría"
      },
      "tu": {
        "italian": "staresti",
        "english": "would be",
        "german": "würdest sein",
        "spanish": "estarías"
      },
      "lui/lei": {
        "italian": "starebbe",
        "english": "would be",
        "german": "würde sein",
        "spanish": "estaría"
      },
      "noi": {
        "italian": "staremmo",
        "english": "would be",
        "german": "würden sein",
        "spanish": "estaríamos"
      },
      "voi": {
        "italian": "stareste",
        "english": "would be",
        "german": "würdet sein",
        "spanish": "estaríais"
      },
      "loro": {
        "italian": "starebbero",
        "english": "would be",
        "german": "würden sein",
        "spanish": "estarían"
      }
    }
  },
  "imperativo": {
    "positivo": {
      "io": null,
      "tu": {
        "italian": "stai",
        "english": "be!",
        "german": "sei!",
        "spanish": "está!"
      },
      "lui/lei": {
        "italian": "stia",
        "english": "be!",
        "german": "sei!",
        "spanish": "esté!"
      },
      "noi": {
        "italian": "stiamo",
        "english": "let's be!",
        "german": "seien wir!",
        "spanish": "estemos!"
      },
      "voi": {
        "italian": "state",
        "english": "(to you plural) be!",
        "german": "seid!",
        "spanish": "estad!"
      },
      "loro": {
        "italian": "stiano",
        "english": "be!",
        "german": "seien Sie!",
        "spanish": "estén!"
      }
    }
  }
};