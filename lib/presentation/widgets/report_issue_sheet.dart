import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';

class ReportIssueSheet extends StatelessWidget {
  const ReportIssueSheet({super.key, required this.reportIssue});
  final Function() reportIssue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppValues.p36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Found an issue?",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs18),
          ),

          SizedBox(height: AppValues.s12),

          FilledButton(
            onPressed: reportIssue,
            style: FilledButton.styleFrom(
              backgroundColor: context.colorScheme.error,
            ),
            child: Text("Report Issue", style: TextStyle(color: context.colorScheme.onError)),
          ),

          SizedBox(height: AppValues.s4),

          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }
}