
import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class ShowSolutionSheet extends StatelessWidget {
  const ShowSolutionSheet({super.key, required this.solution});

  final String? solution;

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
            color: context.colorScheme.error,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FLAG
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.flag, color: context.colorScheme.onError),
                ),

                // LABEL
                Text(
                  "Incorrect",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppValues.fs18,
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

          SizedBox(height: AppValues.s24),

          Text("Correct answer",
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
              child: Text(solution ?? '',
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