import 'package:coniugatto/models/auxiliary.dart';
import 'package:coniugatto/models/moods/base_tense.dart';
import 'package:coniugatto/models/regularity.dart';

import '../models/moods/conditional.dart';
import '../models/moods/imperative.dart';
import '../models/moods/indicative.dart';
import '../models/moods/subjunctive.dart';
import '../models/pronoun.dart';
import '../models/verb.dart';

class CompoundVerbs {
  final Verb essere; // Ausiliare
  final Verb avere; // Ausiliare
  final Verb stare; // Progressivo
  // final Verb andare; // Futuro Prossimo

  const CompoundVerbs({
    required this.essere,
    required this.avere,
    required this.stare,
    // required this.andare,
  });

  // Singleton instance (since these never change)
  static final instance = CompoundVerbs(
    avere: Verb(
      infinitive: "avere",
      translation: "to have",
      regularity: Regularity.irregular,
      auxiliaries: [ Auxiliary.avere ],
      indicative: Indicative.fromJson({
        "indicativo": {
          "presente": {
            "io": "ho",
            "tu": "hai",
            "lui/lei": "ha",
            "noi": "abbiamo",
            "voi": "avete",
            "loro": "hanno"
          },
          "imperfetto": {
            "io": "avevo",
            "tu": "avevi",
            "lui/lei": "aveva",
            "noi": "avevamo",
            "voi": "avevate",
            "loro": "avevano"
          },
          "passato_remoto": {
            "io": "ebbi",
            "tu": "avesti",
            "lui/lei": "ebbe",
            "noi": "avemmo",
            "voi": "aveste",
            "loro": "ebbero"
          },
          "futuro_semplice": {
            "io": "avrò",
            "tu": "avrai",
            "lui/lei": "avrà",
            "noi": "avremo",
            "voi": "avrete",
            "loro": "avranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "abbia",
            "tu": "abbia",
            "lui/lei": "abbia",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "abbiano"
          },
          "imperfetto": {
            "io": "avessi",
            "tu": "avessi",
            "lui/lei": "avesse",
            "noi": "avessimo",
            "voi": "aveste",
            "loro": "avessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "avrei",
            "tu": "avresti",
            "lui/lei": "avrebbe",
            "noi": "avremmo",
            "voi": "avreste",
            "loro": "avrebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "abbi",
            "lui/lei": "-",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "-"
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson({
        "indicativo": {
          "presente": {
            "io": "ho",
            "tu": "hai",
            "lui/lei": "ha",
            "noi": "abbiamo",
            "voi": "avete",
            "loro": "hanno"
          },
          "imperfetto": {
            "io": "avevo",
            "tu": "avevi",
            "lui/lei": "aveva",
            "noi": "avevamo",
            "voi": "avevate",
            "loro": "avevano"
          },
          "passato_remoto": {
            "io": "ebbi",
            "tu": "avesti",
            "lui/lei": "ebbe",
            "noi": "avemmo",
            "voi": "aveste",
            "loro": "ebbero"
          },
          "futuro_semplice": {
            "io": "avrò",
            "tu": "avrai",
            "lui/lei": "avrà",
            "noi": "avremo",
            "voi": "avrete",
            "loro": "avranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "abbia",
            "tu": "abbia",
            "lui/lei": "abbia",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "abbiano"
          },
          "imperfetto": {
            "io": "avessi",
            "tu": "avessi",
            "lui/lei": "avesse",
            "noi": "avessimo",
            "voi": "aveste",
            "loro": "avessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "avrei",
            "tu": "avresti",
            "lui/lei": "avrebbe",
            "noi": "avremmo",
            "voi": "avreste",
            "loro": "avrebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "abbi",
            "lui/lei": "-",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "-"
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson({
        "indicativo": {
          "presente": {
            "io": "ho",
            "tu": "hai",
            "lui/lei": "ha",
            "noi": "abbiamo",
            "voi": "avete",
            "loro": "hanno"
          },
          "imperfetto": {
            "io": "avevo",
            "tu": "avevi",
            "lui/lei": "aveva",
            "noi": "avevamo",
            "voi": "avevate",
            "loro": "avevano"
          },
          "passato_remoto": {
            "io": "ebbi",
            "tu": "avesti",
            "lui/lei": "ebbe",
            "noi": "avemmo",
            "voi": "aveste",
            "loro": "ebbero"
          },
          "futuro_semplice": {
            "io": "avrò",
            "tu": "avrai",
            "lui/lei": "avrà",
            "noi": "avremo",
            "voi": "avrete",
            "loro": "avranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "abbia",
            "tu": "abbia",
            "lui/lei": "abbia",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "abbiano"
          },
          "imperfetto": {
            "io": "avessi",
            "tu": "avessi",
            "lui/lei": "avesse",
            "noi": "avessimo",
            "voi": "aveste",
            "loro": "avessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "avrei",
            "tu": "avresti",
            "lui/lei": "avrebbe",
            "noi": "avremmo",
            "voi": "avreste",
            "loro": "avrebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "abbi",
            "lui/lei": "-",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "-"
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson({
        "indicativo": {
          "presente": {
            "io": "ho",
            "tu": "hai",
            "lui/lei": "ha",
            "noi": "abbiamo",
            "voi": "avete",
            "loro": "hanno"
          },
          "imperfetto": {
            "io": "avevo",
            "tu": "avevi",
            "lui/lei": "aveva",
            "noi": "avevamo",
            "voi": "avevate",
            "loro": "avevano"
          },
          "passato_remoto": {
            "io": "ebbi",
            "tu": "avesti",
            "lui/lei": "ebbe",
            "noi": "avemmo",
            "voi": "aveste",
            "loro": "ebbero"
          },
          "futuro_semplice": {
            "io": "avrò",
            "tu": "avrai",
            "lui/lei": "avrà",
            "noi": "avremo",
            "voi": "avrete",
            "loro": "avranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "abbia",
            "tu": "abbia",
            "lui/lei": "abbia",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "abbiano"
          },
          "imperfetto": {
            "io": "avessi",
            "tu": "avessi",
            "lui/lei": "avesse",
            "noi": "avessimo",
            "voi": "aveste",
            "loro": "avessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "avrei",
            "tu": "avresti",
            "lui/lei": "avrebbe",
            "noi": "avremmo",
            "voi": "avreste",
            "loro": "avrebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "abbi",
            "lui/lei": "-",
            "noi": "abbiamo",
            "voi": "abbiate",
            "loro": "-"
          }
        }
      } ['imperativo']!),
      pastParticiple: "avuto",
      presentGerund: "avendo",
    ),
    essere: Verb(
      infinitive: "essere",
      translation: "to be",
      regularity: Regularity.irregular,
      auxiliaries: [ Auxiliary.essere ],
      indicative: Indicative.fromJson({
        "indicativo": {
          "presente": {
            "io": "sono",
            "tu": "sei",
            "lui/lei": "è",
            "noi": "siamo",
            "voi": "siete",
            "loro": "sono"
          },
          "imperfetto": {
            "io": "ero",
            "tu": "eri",
            "lui/lei": "era",
            "noi": "eravamo",
            "voi": "eravate",
            "loro": "erano"
          },
          "passato_remoto": {
            "io": "fui",
            "tu": "fosti",
            "lui/lei": "fu",
            "noi": "fummo",
            "voi": "foste",
            "loro": "furono"
          },
          "futuro_semplice": {
            "io": "sarò",
            "tu": "sarai",
            "lui/lei": "sarà",
            "noi": "saremo",
            "voi": "sarete",
            "loro": "saranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "sia",
            "tu": "sia",
            "lui/lei": "sia",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          },
          "imperfetto": {
            "io": "fossi",
            "tu": "fossi",
            "lui/lei": "fosse",
            "noi": "fossimo",
            "voi": "foste",
            "loro": "fossero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "sarei",
            "tu": "saresti",
            "lui/lei": "sarebbe",
            "noi": "saremmo",
            "voi": "sareste",
            "loro": "sarebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sii",
            "lui/lei": "-",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson({
        "indicativo": {
          "presente": {
            "io": "sono",
            "tu": "sei",
            "lui/lei": "è",
            "noi": "siamo",
            "voi": "siete",
            "loro": "sono"
          },
          "imperfetto": {
            "io": "ero",
            "tu": "eri",
            "lui/lei": "era",
            "noi": "eravamo",
            "voi": "eravate",
            "loro": "erano"
          },
          "passato_remoto": {
            "io": "fui",
            "tu": "fosti",
            "lui/lei": "fu",
            "noi": "fummo",
            "voi": "foste",
            "loro": "furono"
          },
          "futuro_semplice": {
            "io": "sarò",
            "tu": "sarai",
            "lui/lei": "sarà",
            "noi": "saremo",
            "voi": "sarete",
            "loro": "saranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "sia",
            "tu": "sia",
            "lui/lei": "sia",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          },
          "imperfetto": {
            "io": "fossi",
            "tu": "fossi",
            "lui/lei": "fosse",
            "noi": "fossimo",
            "voi": "foste",
            "loro": "fossero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "sarei",
            "tu": "saresti",
            "lui/lei": "sarebbe",
            "noi": "saremmo",
            "voi": "sareste",
            "loro": "sarebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sii",
            "lui/lei": "-",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson({
        "indicativo": {
          "presente": {
            "io": "sono",
            "tu": "sei",
            "lui/lei": "è",
            "noi": "siamo",
            "voi": "siete",
            "loro": "sono"
          },
          "imperfetto": {
            "io": "ero",
            "tu": "eri",
            "lui/lei": "era",
            "noi": "eravamo",
            "voi": "eravate",
            "loro": "erano"
          },
          "passato_remoto": {
            "io": "fui",
            "tu": "fosti",
            "lui/lei": "fu",
            "noi": "fummo",
            "voi": "foste",
            "loro": "furono"
          },
          "futuro_semplice": {
            "io": "sarò",
            "tu": "sarai",
            "lui/lei": "sarà",
            "noi": "saremo",
            "voi": "sarete",
            "loro": "saranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "sia",
            "tu": "sia",
            "lui/lei": "sia",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          },
          "imperfetto": {
            "io": "fossi",
            "tu": "fossi",
            "lui/lei": "fosse",
            "noi": "fossimo",
            "voi": "foste",
            "loro": "fossero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "sarei",
            "tu": "saresti",
            "lui/lei": "sarebbe",
            "noi": "saremmo",
            "voi": "sareste",
            "loro": "sarebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sii",
            "lui/lei": "-",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson({
        "indicativo": {
          "presente": {
            "io": "sono",
            "tu": "sei",
            "lui/lei": "è",
            "noi": "siamo",
            "voi": "siete",
            "loro": "sono"
          },
          "imperfetto": {
            "io": "ero",
            "tu": "eri",
            "lui/lei": "era",
            "noi": "eravamo",
            "voi": "eravate",
            "loro": "erano"
          },
          "passato_remoto": {
            "io": "fui",
            "tu": "fosti",
            "lui/lei": "fu",
            "noi": "fummo",
            "voi": "foste",
            "loro": "furono"
          },
          "futuro_semplice": {
            "io": "sarò",
            "tu": "sarai",
            "lui/lei": "sarà",
            "noi": "saremo",
            "voi": "sarete",
            "loro": "saranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "sia",
            "tu": "sia",
            "lui/lei": "sia",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          },
          "imperfetto": {
            "io": "fossi",
            "tu": "fossi",
            "lui/lei": "fosse",
            "noi": "fossimo",
            "voi": "foste",
            "loro": "fossero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "sarei",
            "tu": "saresti",
            "lui/lei": "sarebbe",
            "noi": "saremmo",
            "voi": "sareste",
            "loro": "sarebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sii",
            "lui/lei": "-",
            "noi": "siamo",
            "voi": "siate",
            "loro": "siano"
          }
        }
      } ['imperativo']!),
      pastParticiple: "stato",
      presentGerund: "essendo",
  ),
    stare: Verb(
      infinitive: "stare",
      translation: "to stay, to be (temporary)",
      regularity: Regularity.irregular,
      auxiliaries: [ Auxiliary.essere ],
      indicative: Indicative.fromJson({
        "indicativo": {
          "presente": {
            "io": "sto",
            "tu": "stai",
            "lui/lei": "sta",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stanno"
          },
          "imperfetto": {
            "io": "stavo",
            "tu": "stavi",
            "lui/lei": "stava",
            "noi": "stavamo",
            "voi": "stavate",
            "loro": "stavano"
          },
          "passato_remoto": {
            "io": "stetti",
            "tu": "stesti",
            "lui/lei": "stette",
            "noi": "stemmo",
            "voi": "steste",
            "loro": "stettero"
          },
          "futuro_semplice": {
            "io": "starò",
            "tu": "starai",
            "lui/lei": "starà",
            "noi": "staremo",
            "voi": "starete",
            "loro": "staranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "stia",
            "tu": "stia",
            "lui/lei": "stia",
            "noi": "stiamo",
            "voi": "stiate",
            "loro": "stiano"
          },
          "imperfetto": {
            "io": "stessi",
            "tu": "stessi",
            "lui/lei": "stesse",
            "noi": "stessimo",
            "voi": "steste",
            "loro": "stessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "starei",
            "tu": "staresti",
            "lui/lei": "starebbe",
            "noi": "staremmo",
            "voi": "stareste",
            "loro": "starebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sta' (or stai)",
            "lui/lei": "-",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stiano"
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson({
        "indicativo": {
          "presente": {
            "io": "sto",
            "tu": "stai",
            "lui/lei": "sta",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stanno"
          },
          "imperfetto": {
            "io": "stavo",
            "tu": "stavi",
            "lui/lei": "stava",
            "noi": "stavamo",
            "voi": "stavate",
            "loro": "stavano"
          },
          "passato_remoto": {
            "io": "stetti",
            "tu": "stesti",
            "lui/lei": "stette",
            "noi": "stemmo",
            "voi": "steste",
            "loro": "stettero"
          },
          "futuro_semplice": {
            "io": "starò",
            "tu": "starai",
            "lui/lei": "starà",
            "noi": "staremo",
            "voi": "starete",
            "loro": "staranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "stia",
            "tu": "stia",
            "lui/lei": "stia",
            "noi": "stiamo",
            "voi": "stiate",
            "loro": "stiano"
          },
          "imperfetto": {
            "io": "stessi",
            "tu": "stessi",
            "lui/lei": "stesse",
            "noi": "stessimo",
            "voi": "steste",
            "loro": "stessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "starei",
            "tu": "staresti",
            "lui/lei": "starebbe",
            "noi": "staremmo",
            "voi": "stareste",
            "loro": "starebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sta' (or stai)",
            "lui/lei": "-",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stiano"
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson({
        "indicativo": {
          "presente": {
            "io": "sto",
            "tu": "stai",
            "lui/lei": "sta",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stanno"
          },
          "imperfetto": {
            "io": "stavo",
            "tu": "stavi",
            "lui/lei": "stava",
            "noi": "stavamo",
            "voi": "stavate",
            "loro": "stavano"
          },
          "passato_remoto": {
            "io": "stetti",
            "tu": "stesti",
            "lui/lei": "stette",
            "noi": "stemmo",
            "voi": "steste",
            "loro": "stettero"
          },
          "futuro_semplice": {
            "io": "starò",
            "tu": "starai",
            "lui/lei": "starà",
            "noi": "staremo",
            "voi": "starete",
            "loro": "staranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "stia",
            "tu": "stia",
            "lui/lei": "stia",
            "noi": "stiamo",
            "voi": "stiate",
            "loro": "stiano"
          },
          "imperfetto": {
            "io": "stessi",
            "tu": "stessi",
            "lui/lei": "stesse",
            "noi": "stessimo",
            "voi": "steste",
            "loro": "stessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "starei",
            "tu": "staresti",
            "lui/lei": "starebbe",
            "noi": "staremmo",
            "voi": "stareste",
            "loro": "starebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sta' (or stai)",
            "lui/lei": "-",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stiano"
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson({
        "indicativo": {
          "presente": {
            "io": "sto",
            "tu": "stai",
            "lui/lei": "sta",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stanno"
          },
          "imperfetto": {
            "io": "stavo",
            "tu": "stavi",
            "lui/lei": "stava",
            "noi": "stavamo",
            "voi": "stavate",
            "loro": "stavano"
          },
          "passato_remoto": {
            "io": "stetti",
            "tu": "stesti",
            "lui/lei": "stette",
            "noi": "stemmo",
            "voi": "steste",
            "loro": "stettero"
          },
          "futuro_semplice": {
            "io": "starò",
            "tu": "starai",
            "lui/lei": "starà",
            "noi": "staremo",
            "voi": "starete",
            "loro": "staranno"
          }
        },
        "congiuntivo": {
          "presente": {
            "io": "stia",
            "tu": "stia",
            "lui/lei": "stia",
            "noi": "stiamo",
            "voi": "stiate",
            "loro": "stiano"
          },
          "imperfetto": {
            "io": "stessi",
            "tu": "stessi",
            "lui/lei": "stesse",
            "noi": "stessimo",
            "voi": "steste",
            "loro": "stessero"
          }
        },
        "condizionale": {
          "presente": {
            "io": "starei",
            "tu": "staresti",
            "lui/lei": "starebbe",
            "noi": "staremmo",
            "voi": "stareste",
            "loro": "starebbero"
          }
        },
        "imperativo": {
          "positivo": {
            "io": "-",
            "tu": "sta' (or stai)",
            "lui/lei": "-",
            "noi": "stiamo",
            "voi": "state",
            "loro": "stiano"
          }
        }
      } ['imperativo']!),
      pastParticiple: "stato",
      presentGerund: "stando",
    ),
  );

  String? conjugateAuxiliary(Pronoun pronoun, Auxiliary auxiliary, BaseTense tense) {
    final verb = switch (auxiliary) {
      Auxiliary.avere => avere,
      Auxiliary.essere => essere,
    };

    return switch (tense) {
      BaseTense.present => verb.indicative.present[pronoun],
      BaseTense.imperfect => verb.indicative.imperfect[pronoun],
      BaseTense.future => verb.indicative.future[pronoun],
      BaseTense.historicalPresentPerfect => verb.indicative.historicalPresentPerfect[pronoun],
      BaseTense.presentSubjunctive => verb.subjunctive.present[pronoun],
      BaseTense.imperfectSubjunctive => verb.subjunctive.imperfect[pronoun],
      BaseTense.presentConditional => verb.conditional.present[pronoun],
    };
  }

  String? conjugateStare(Pronoun pronoun) => stare.indicative.present[pronoun];
}