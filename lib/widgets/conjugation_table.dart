import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../models/pronoun.dart';
import '../models/tenses/tense.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.tenses, this.showEnglishPronouns = true});

  final List<Tense> tenses;
  final bool showEnglishPronouns;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.r12),
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
                headingRowColor: WidgetStateColor.resolveWith((states) => context.colors.scheme.inverseSurface),
                dividerThickness: AppValues.s1,
                dataRowMinHeight: AppValues.s48,
                dataRowMaxHeight: AppValues.s52,
                headingRowHeight: AppValues.s56,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  //color: Theme.of(context).cardColor,
                ),
                columns: _buildTenseColumns(context),
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
        headingRowColor: WidgetStateColor.resolveWith((states) => context.colors.scheme.inverseSurface),
        dividerThickness: AppValues.s1,
        dataRowMinHeight: AppValues.s48,
        dataRowMaxHeight: AppValues.s52,
        headingRowHeight: AppValues.s56,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          //color: Theme.of(context).cardColor,
        ),
        columns: [
          DataColumn(
            label: Text('Pronoun',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.colors.scheme.onInverseSurface,
                fontSize: AppValues.fs14,
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
                  fontSize: AppValues.fs13,
                ),
              ),
            ),
          ],
        )).toList()
    );
  }

  _buildTenseColumns(BuildContext context) => tenses.map((tense) => DataColumn(
    label: Tooltip(
      message: tense.label,
      child: Text(tense.label,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: context.colors.scheme.onInverseSurface,
          fontSize: AppValues.fs13,
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
