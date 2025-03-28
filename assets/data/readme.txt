# Verb JSON Structure
- Regular verbs are marked as "type": "regular"
- Irregular verbs are marked as "type": "irregular"
- Conjugations are stored under "conjugations"

Example:
{
   "infinitive":"volere",
   "translation":"to want",
   "type":"irregular",
   "auxiliary": ["avere"],
   "conjugations":{
      "indicativo":{
         "presente":{
            "io":"voglio",
            "tu":"vuoi",
            "lui/lei":"vuole",
            "noi":"vogliamo",
            "voi":"volete",
            "loro":"vogliono"
         },
         "imperfetto":{
            "io":"volevo",
            "tu":"volevi",
            "lui/lei":"voleva",
            "noi":"volevamo",
            "voi":"volevate",
            "loro":"volevano"
         },
         "passato_remoto":{
            "io":"volli",
            "tu":"volesti",
            "lui/lei":"volle",
            "noi":"vollemmo",
            "voi":"voleste",
            "loro":"vollero"
         },
         "futuro_semplice":{
            "io":"vorrò",
            "tu":"vorrai",
            "lui/lei":"vorrà",
            "noi":"vorremo",
            "voi":"vorrete",
            "loro":"vorranno"
         },
      },
      "congiuntivo":{
         "presente":{
            "io":"voglia",
            "tu":"voglia",
            "lui/lei":"voglia",
            "noi":"vogliamo",
            "voi":"vogliate",
            "loro":"vogliano"
         },
         "imperfetto":{
            "io":"volessi",
            "tu":"volessi",
            "lui/lei":"volesse",
            "noi":"volessimo",
            "voi":"voleste",
            "loro":"volessero"
         },
      },
      "condizionale":{
         "presente":{
            "io":"vorrei",
            "tu":"vorresti",
            "lui/lei":"vorrebbe",
            "noi":"vorremmo",
            "voi":"vorreste",
            "loro":"vorrebbero"
         },
      },
      "imperativo":{
         "tu":"vogli",
         "lui/lei":"-",
         "noi":"vogliamo",
         "voi":"vogliate",
         "loro":"vogliano"
      },
      "participio_passato": "voluto",
      "gerundio_presente": "volendo",
   }
},