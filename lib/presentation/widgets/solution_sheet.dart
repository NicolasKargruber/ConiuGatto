import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';
import 'report_issue_sheet.dart';


// TODO Move to general widgets
class SolutionSheet extends StatelessWidget {
  const SolutionSheet({super.key, required this.solution, required this.reportIssue});

  final String solution;
  final Function() reportIssue;

  // TODO Use Navigator
  _showReportIssueSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      builder: (_) {
        return ReportIssueSheet(reportIssue: reportIssue);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.p48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: AppValues.p8, vertical: AppValues.p8),
            decoration: BoxDecoration(
              color: context.colorScheme.error,
              borderRadius: BorderRadius.all(Radius.circular(AppValues.r4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FLAG
                IconButton(
                    onPressed: () => _showReportIssueSheet(context),
                    icon: Icon(Icons.flag, color: context.colorScheme.onError),
                ),

                // LABEL
                Text(
                  context.localization.incorrectLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppValues.fs24,
                    color: context.colorScheme.onError,
                  ),
                ),

                // CLOSE
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: context.colorScheme.onError),
                ),
              ],
            ),
          ),

          SizedBox(height: AppValues.s20),

          Text(
            context.localization.correctAnswerLabel,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs20),
          ),

          SizedBox(height: AppValues.s12),

          Center(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.errorContainer,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(AppValues.r12)),
              ),
              padding: EdgeInsets.all(AppValues.p12),
              child: Text(solution,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppValues.fs24,
                    color: context.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}