import 'package:coniugatto/models/auxiliary.dart';
import 'package:coniugatto/models/regularity.dart';

import '../models/moods/moods.dart';
import '../models/verb.dart';

class CompoundVerbs {
  final Verb essere; // Ausiliare
  final Verb avere; // Ausiliare
  final Verb stare; // Progressivo
  // final Verb andare; // Futuro

  const CompoundVerbs({
    required this.essere,
    required this.avere,
    required this.stare,
    // required this.andare,
  });

  // Singleton instance (since these never change)
  static var instance = CompoundVerbs(
    avere: Verb(
        infinitive: "avere",
        translation: "to have",
        regularity: Regularity.irregular,
        auxiliaries: [ Auxiliary.avere ],
        moods: Moods.fromJson({
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
        }),
        pastParticiple: "avuto",
        presentGerund: "avendo",
    ),
    essere: Verb(
      infinitive: "essere",
      translation: "to be",
      regularity: Regularity.irregular,
      auxiliaries: [ Auxiliary.essere ],
      moods: Moods.fromJson({
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
      }),
      pastParticiple: "stato",
      presentGerund: "essendo",
  ),
    stare: Verb(
      infinitive: "stare",
      translation: "to stay, to be (temporary)",
      regularity: Regularity.irregular,
      auxiliaries: [ Auxiliary.essere ],
      moods: Moods.fromJson({
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
      }),
      pastParticiple: "stato",
      presentGerund: "stando",
    ),
  );

  /*// Helper methods
  Verb getAuxiliary(Auxiliary auxiliary) => switch (auxiliary) {
    Auxiliary.avere => essere,
    Auxiliary.avere => avere,
  };*/

  bool isHelperVerb(String infinitive) =>
      [essere.infinitive, avere.infinitive, stare.infinitive].contains(infinitive);
}