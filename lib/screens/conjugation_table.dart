import 'package:coniugatto/models/moods/indicative.dart';
import 'package:flutter/material.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.conjugations});

  final Conjugations conjugations;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(child: Text('Pronoun', style: TextStyle(fontStyle: FontStyle.italic))),
        ),
        DataColumn(
          label: Expanded(child: Text('Verb', style: TextStyle(fontStyle: FontStyle.italic))),
        ),
      ],
      rows: conjugations.entries.map((entry) => DataRow(
        cells: <DataCell>[
          DataCell(Text(entry.key.italian)),
          DataCell(Text(entry.value ?? "-")),
        ],
      )).toList()
    );
  }
}