import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/tenses/conjugation.dart';
import '../../../domain/models/tenses/tense.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../widgets/custom_data_table.dart';
import '../../widgets/report_issue_sheet.dart';
import '../view_models/verb_detail_view_model.dart';

class ConjugationTable extends StatelessWidget {
  const ConjugationTable({super.key, required this.tenses});

  final List<Tense> tenses;
  //final bool includeEnglishPronouns;

  // TODO Use Navigator
  _showReportIssueSheet(BuildContext context, Tense tense) async {
    final viewModel = context.read<VerbDetailViewModel>();
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ReportIssueSheet(reportIssue: () => viewModel.reportTense(tense));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppValues.r12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed Section
          // "Pronoun" + (io, tu, lui/lei, noi, voi, loro)
          PronounTable(),
      
          // Scrollable Section
          // Tenses (Presente, ...) + Conjugations (mangio, mangi, ...)
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomDataTable(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                    top: BorderSide(color: Colors.grey.shade300),
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppValues.r12),
                    bottomRight: Radius.circular(AppValues.r12),
                  ),
                  //color: Theme.of(context).cardColor,
                ),
                columns: tenses.map(_dataColumnsFromTense).toList(),
                rows: Pronoun.values.map(_dataRowsFromPronoun).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataColumn _dataColumnsFromTense(Tense tense) => DataColumn(
    label: Builder(
      builder: (context) {
        return Row(
          children: [
            Tooltip(
              message: tense.label,
              child: Text(tense.label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.onInverseSurface,
                  fontSize: AppValues.fs13,
                ),
              ),
            ),

            IconButton(
              icon: Icon(Icons.flag),
              onPressed: () => _showReportIssueSheet(context, tense),
              iconSize: AppValues.s20,
              color: context.colorScheme.onInverseSurface,
            ),
          ],
        );
      }
    ),
  );

  DataRow _dataRowsFromPronoun(Pronoun pronoun) => DataRow(
    cells: tenses.map((tense) => _dataCellsFromTense(tense[pronoun])).toList(),
  );

  DataCell _dataCellsFromTense(Conjugation? conjugation) => DataCell(
    Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(conjugation != null) ...[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: conjugation.italianRegularPart,
                      style: TextStyle(color: context.colorScheme.onSurface),
                    ),
                    TextSpan(
                      text: conjugation.italianIrregularPart,
                      style: TextStyle(color: context.colorScheme.secondary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(conjugation.englishWithPronoun,
                  style: TextStyle(fontStyle: FontStyle.italic)
              )
            ]
            else Text("-")
          ],
        );
      }
    ),
  );
}

class PronounTable extends StatelessWidget {
  const PronounTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDataTable(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppValues.r12),
              bottomLeft: Radius.circular(AppValues.r12),
            ),
            color: context.theme.highlightColor.withValues(alpha: 0.2)
        ),
        columns: [
          DataColumn(
            label: Text('Pronoun',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.colorScheme.onInverseSurface,
                fontSize: AppValues.fs14,
              ),
            ),
          ),
        ],
        rows: Pronoun.values.map((pronoun) => _dataRowFromLabel(pronoun.italian)).toList(),
    );
  }

  DataRow _dataRowFromLabel(String label) => DataRow(
    cells: [
      DataCell(
        Text(label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppValues.fs13,
          ),
        ),
      ),
    ],
  );
}

