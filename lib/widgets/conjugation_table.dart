import 'package:coniugatto/models/pronoun.dart';
import 'package:flutter/material.dart';

import '../models/tense.dart';
import '../models/verb.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.tenses, this.showEnglishPronouns = true});

  final List<Tense> tenses;
  final bool showEnglishPronouns;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Expanded(child: Text('Pronoun', style: TextStyle(fontStyle: FontStyle.italic))),),
        ...tenses.map((tense) =>
            DataColumn(label: Expanded(child: Text(tense.name, style: TextStyle(fontStyle: FontStyle.italic))))
        )
      ],
      rows: Pronoun.values.map((pronoun) => DataRow(
        cells: <DataCell>[
          DataCell(Text(pronoun.italian)),
          ...tenses.map((tense) =>
              DataCell(Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(tense.conjugations[pronoun] != null) ...[
                      Text(tense.conjugations[pronoun]?.italian ?? "-"),
                      Text("${showEnglishPronouns ? "${pronoun.english} " : ""}${tense.conjugations[pronoun]?.english
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