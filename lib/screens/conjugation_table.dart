import 'package:coniugatto/models/pronoun.dart';
import 'package:flutter/material.dart';

import '../models/verb.dart';

typedef ConjugatedTense = ({String label, Conjugations conjugations});

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.conjugatedTenses, this.showEnglishPronouns = true});

  final List<ConjugatedTense> conjugatedTenses;
  final bool showEnglishPronouns;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Expanded(child: Text('Pronoun', style: TextStyle(fontStyle: FontStyle.italic))),),
        ...conjugatedTenses.map((conjugatedTense) =>
            DataColumn(label: Expanded(child: Text(conjugatedTense.label, style: TextStyle(fontStyle: FontStyle.italic))))
        )
      ],
      rows: Pronoun.values.map((pronoun) => DataRow(
        cells: <DataCell>[
          DataCell(Text(pronoun.italian)),
          ...conjugatedTenses.map((conjugatedTense) =>
              DataCell(Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(conjugatedTense.conjugations[pronoun] != null) ...[
                      Text(conjugatedTense.conjugations[pronoun]?.italian ?? "-"),
                      Text("${showEnglishPronouns ? "${pronoun.english} " : ""}${conjugatedTense.conjugations[pronoun]?.english
                      }", style: TextStyle(fontStyle: FontStyle.italic))]
                  else Text("-")
                ],
              ))
          ),
        ],
      )).toList()
    );
  }
}