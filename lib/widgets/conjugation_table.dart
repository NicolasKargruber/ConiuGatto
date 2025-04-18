import '../models/pronoun.dart';
import 'package:flutter/material.dart';

import '../models/tenses/tense.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.tenses, this.showEnglishPronouns = true});

  final List<Tense> tenses;
  final bool showEnglishPronouns;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed Section
          // Pronouns (io, tu, lui/lei, noi, voi, loro)
          _buildPronounTable(context),

          // Scrollable Section:
          // Tenses (Presente, ...) + Conjugations (mangio, mangi, ...)
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateColor.resolveWith((states) => Colors.indigo.shade50),
                dividerThickness: 1,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 52,
                headingRowHeight: 56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  color: Theme.of(context).cardColor,
                ),
                columns: _buildTenseColumns(),
                rows: _buildTenseRows(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPronounTable(BuildContext context){
    return DataTable(
        headingRowColor: WidgetStateColor.resolveWith((states) => Colors.indigo.shade50),
        dividerThickness: 1,
        dataRowMinHeight: 48,
        dataRowMaxHeight: 52,
        headingRowHeight: 56,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          color: Theme.of(context).cardColor,
        ),
        columns: [
          DataColumn(
            label: Text('Pronoun',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade800,
                fontSize: 14,
              ),
            ),
          ),
        ],
        rows: Pronoun.values.map((pronoun) => DataRow(
          cells: [
            DataCell(
              Text(pronoun.italian,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade900,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        )).toList()
    );
  }

  _buildTenseColumns() => tenses.map((tense) => DataColumn(
    label: Tooltip(
      message: tense.label,
      child: Text(tense.label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey.shade700,
          fontSize: 13,
        ),
      ),
    ),
  )).toList();

  _buildTenseRows() => Pronoun.values.map((pronoun) =>
      DataRow(
        cells: tenses.map((tense) =>
            DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(tense.conjugations[pronoun] != null) ...[
                    Text(tense.conjugations[pronoun]?.italian ?? "-"),
                    Text(
                        "${showEnglishPronouns ? "${pronoun.english} " : ""}${tense.conjugations[pronoun]?.english}",
                        style: TextStyle(fontStyle: FontStyle.italic)
                    )
                  ]
                  else Text("-")
                ],
              ),
            )).toList(),
      )).toList();
}
