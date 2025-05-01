
import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';

class ShowSolutionSheet extends StatelessWidget {
  const ShowSolutionSheet({
    super.key,
    required this.solution,
  });

  final String? solution;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.p48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppValues.p12),
            child: Text(
              "Correct answer",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppValues.fs20,
              ),
            ),
          ),

          IntrinsicWidth(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(AppValues.r12)),
              ),
              padding: EdgeInsets.all(AppValues.p12),
              child: Text(
                solution ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppValues.fs28,
                    color: Colors.green.shade700
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}