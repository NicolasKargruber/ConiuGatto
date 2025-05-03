import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../view_models/quiz_view_model.dart';

class QuizHistoryCount extends StatelessWidget {
  const QuizHistoryCount({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();
    return viewModel.hasQuizzableItems ? Row(
      children: [
        Text("${viewModel.negativeQuizCount}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
        ),
        SizedBox(width: AppValues.s2),
        Text("❌"),
        SizedBox(width: AppValues.s8),
        Text("${viewModel.positiveQuizCount}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
        ),
        SizedBox(width: AppValues.s2),
        Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: AppValues.fs20)),
      ],
    ) : Spacer();
  }
}