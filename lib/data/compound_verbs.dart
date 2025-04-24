import '../models/auxiliary.dart';
import '../models/moods/simple_tense.dart';
import '../models/regularity.dart';

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

  // Private Constructor
  const CompoundVerbs._({
    required this.essere,
    required this.avere,
    required this.stare,
    // required this.andare,
  });

  // Singleton instance (since these never change)
  static final instance = CompoundVerbs._(
    avere: Verb(
      infinitive: (italian: "avere", english: "to have"),
      regularity: Regularity.irregular,
      auxiliaries: { Auxiliary.avere},
      indicative: Indicative.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "abbi",
              "english": "(to you) have!"
            },
            "lui/lei": {
              "italian": "abbia",
              "english": "(to you formal) have!"
            },
            "noi": {
              "italian": "abbiamo",
              "english": "let's have!"
            },
            "voi": {
              "italian": "abbiate",
              "english": "(to you plural) have!"
            },
            "loro": {
              "italian": "abbiano",
              "english": "(to you plural formal) have!"
            }
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "abbi",
              "english": "(to you) have!"
            },
            "lui/lei": {
              "italian": "abbia",
              "english": "(to you formal) have!"
            },
            "noi": {
              "italian": "abbiamo",
              "english": "let's have!"
            },
            "voi": {
              "italian": "abbiate",
              "english": "(to you plural) have!"
            },
            "loro": {
              "italian": "abbiano",
              "english": "(to you plural formal) have!"
            }
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "abbi",
              "english": "(to you) have!"
            },
            "lui/lei": {
              "italian": "abbia",
              "english": "(to you formal) have!"
            },
            "noi": {
              "italian": "abbiamo",
              "english": "let's have!"
            },
            "voi": {
              "italian": "abbiate",
              "english": "(to you plural) have!"
            },
            "loro": {
              "italian": "abbiano",
              "english": "(to you plural formal) have!"
            }
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "abbi",
              "english": "(to you) have!"
            },
            "lui/lei": {
              "italian": "abbia",
              "english": "(to you formal) have!"
            },
            "noi": {
              "italian": "abbiamo",
              "english": "let's have!"
            },
            "voi": {
              "italian": "abbiate",
              "english": "(to you plural) have!"
            },
            "loro": {
              "italian": "abbiano",
              "english": "(to you plural formal) have!"
            }
          }
        }
      } ['imperativo']!),
      pastParticiple: (italian: "avuto", english: "had"),
      presentGerund: (italian: "avendo", english: "having"),
    ),
    essere: Verb(
      infinitive: (italian: "essere", english: "to be (permanent)"),
      regularity: Regularity.irregular,
      auxiliaries: { Auxiliary.essere},
      indicative: Indicative.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "sii",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "sia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "siamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "siate",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "siano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "sii",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "sia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "siamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "siate",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "siano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "sii",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "sia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "siamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "siate",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "siano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson({
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "sii",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "sia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "siamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "siate",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "siano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['imperativo']!),
      pastParticiple: (italian: "stato", english: "been"),
      presentGerund: (italian: "essendo", english: "being"),
  ),
    stare: Verb(
      infinitive: (italian: "stare", english: "to stay, to be (temporary)"),
      regularity: Regularity.irregular,
      auxiliaries: { Auxiliary.essere},
      indicative: Indicative.fromJson( {
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "stai",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "stia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "stiamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "state",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "stiano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['indicativo']!),
      subjunctive: Subjunctive.fromJson( {
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "stai",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "stia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "stiamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "state",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "stiano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['congiuntivo']!),
      conditional: Conditional.fromJson( {
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "stai",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "stia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "stiamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "state",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "stiano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['condizionale']!),
      imperative: Imperative.fromJson( {
        "indicativo": {
          "presente": {
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
          },
          "imperfetto": {
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
          },
          "passato_remoto": {
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
          },
          "futuro_semplice": {
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
          }
        },
        "congiuntivo": {
          "presente": {
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
          },
          "imperfetto": {
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
          }
        },
        "condizionale": {
          "presente": {
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
          }
        },
        "imperativo": {
          "positivo": {
            "io": null,
            "tu": {
              "italian": "stai",
              "english": "(to you) be!"
            },
            "lui/lei": {
              "italian": "stia",
              "english": "(to you formal) be!"
            },
            "noi": {
              "italian": "stiamo",
              "english": "let's be!"
            },
            "voi": {
              "italian": "state",
              "english": "(to you plural) be!"
            },
            "loro": {
              "italian": "stiano",
              "english": "(to you plural formal) be!"
            }
          }
        }
      } ['imperativo']!),
      pastParticiple: (italian: "stato", english: "been"),
      presentGerund: (italian: "stando", english: "being"),
    ),
  );

  String? conjugateItalianAuxiliary(Pronoun pronoun, Auxiliary auxiliary, SimpleTense tense) {
    final verb = switch (auxiliary) {
      Auxiliary.avere => avere,
      Auxiliary.essere => essere,
    };

    return switch (tense) {
      SimpleTense.present => verb.indicative.present[pronoun]?.italian,
      SimpleTense.imperfect => verb.indicative.imperfect[pronoun]?.italian,
      SimpleTense.future => verb.indicative.future[pronoun]?.italian,
      SimpleTense.historicalPresentPerfect => verb.indicative.historicalPresentPerfect[pronoun]?.italian,
      SimpleTense.presentSubjunctive => verb.subjunctive.present[pronoun]?.italian,
      SimpleTense.imperfectSubjunctive => verb.subjunctive.imperfect[pronoun]?.italian,
      SimpleTense.presentConditional => verb.conditional.present[pronoun]?.italian,
    };
  }

  String? conjugateEnglishAuxiliary(Pronoun pronoun, SimpleTense tense) {
    return switch (tense) {
      SimpleTense.present => avere.indicative.present[pronoun]?.english,
      SimpleTense.imperfect => avere.indicative.historicalPresentPerfect[pronoun]?.english,
      SimpleTense.future => "will have",
      SimpleTense.historicalPresentPerfect => avere.indicative.historicalPresentPerfect[pronoun]?.english,
      SimpleTense.presentSubjunctive => avere.subjunctive.present[pronoun]?.english,
      SimpleTense.imperfectSubjunctive => avere.indicative.historicalPresentPerfect[pronoun]?.english,
      SimpleTense.presentConditional => avere.conditional.present[pronoun]?.english,
    };
  }

  String? conjugateStare(Pronoun pronoun, {SimpleTense tense = SimpleTense.present}) =>
      stare.indicative.present[pronoun]?.italian;

  String? conjugateStareInEnglish(Pronoun pronoun, {SimpleTense tense = SimpleTense.present}) =>
      stare.indicative.present[pronoun]?.english;
}