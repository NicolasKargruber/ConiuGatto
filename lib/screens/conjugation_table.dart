import 'package:coniugatto/models/pronoun.dart';
import 'package:flutter/material.dart';

import '../models/verb.dart';

typedef ConjugatedTense = ({String label, Conjugations conjugations});

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.conjugatedTenses});

  final List<ConjugatedTense> conjugatedTenses;

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
              DataCell(Text((conjugatedTense.conjugations as Map)[pronoun] ?? "-"))
          ),
        ],
      )).toList()
    );
  }
}