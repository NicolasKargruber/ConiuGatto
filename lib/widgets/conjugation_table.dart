import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';

import '../data/app_values.dart';
import '../models/pronoun.dart';
import '../models/tenses/tense.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.tenses, this.showEnglishPronouns = true, this.stem = ""});

  final String stem;
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
                decoration: BoxDecoration(border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                    top: BorderSide(color: Colors.grey.shade300),
                    bottom: BorderSide(color: Colors.grey.shade300))
                  ,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppValues.r12),
                    bottomRight: Radius.circular(AppValues.r12),
                  ),
                  //color: Theme.of(context).cardColor,
                ),
                columns: _buildTenseColumns(context),
                rows: _buildTenseRows(context),
                clipBehavior: Clip.hardEdge,
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

        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppValues.r12),
              bottomLeft: Radius.circular(AppValues.r12),
            ),
            color: context.colors.highlight.withValues(alpha: 0.2)
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

  // TODO Move to ViewModel
  _buildTenseRows(BuildContext context) {
    // Helper function to highlight irregular parts
    List<TextSpan> buildSpans(String conjugatedForm, String? generatedForm) {
      List<TextSpan> spans = [];
      int i = 0;

      // Check if generated is provided
      if (generatedForm == null) {
        return spans..add(TextSpan(text: conjugatedForm,
            style: const TextStyle(color: Colors.black)));
      }

      // TODO Use
      // When conjugation is shorter than generation
      /*if (conjugatedForm.length < generatedForm.length) {
        spans.add(TextSpan(text: stem, style: const TextStyle(color: Colors.black)));
        spans.add(TextSpan(text: conjugatedForm.substring(stem.length), style: const TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.bold)));
        return spans;
      }*/

      // debugPrint("conjugatedForm: $conjugatedForm");
      // debugPrint("generatedForm: $generatedForm");

      // Find the matching prefix (regular part)
      while (i < generatedForm.length &&
          i < conjugatedForm.length &&
          conjugatedForm[i].toLowerCase() == generatedForm[i].toLowerCase()) {
        i++;
      }

      // Add regular part in default style
      if (i > 0) {
        spans.add(TextSpan(
          text: conjugatedForm.substring(0, i),
          style: TextStyle(color: context.colors.scheme.onSurface),
        ));
      }

      // Add irregular part in red
      if (i < conjugatedForm.length) {
        spans.add(TextSpan(
          text: conjugatedForm.substring(i),
          style: TextStyle(color: context.colors.scheme.secondary, fontWeight: FontWeight.bold),
        ));
      }

      return spans;
    }

    return Pronoun.values.map((pronoun) =>
      DataRow(
        cells: tenses.map((tense) =>
            DataCell(
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(tense.conjugations[pronoun] != null) ...[
            RichText(
              text: TextSpan(
                children: buildSpans(tense.conjugations[pronoun]?.italian ?? "-", tense.generatedConjugations?[pronoun]),
              ),
            ),
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
}
