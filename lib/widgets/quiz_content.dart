import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/app_values.dart';
import '../view_models/quiz_view_model.dart';

class QuizContent extends StatelessWidget {
  const QuizContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(viewModel.isDoubleAuxiliary)
            Chip(label: Text("${viewModel.currentAuxiliary?.name.toUpperCase()}")),
          SizedBox(height: AppValues.s4),
          AutoSizeText(
            viewModel.currentTitle ?? "Not available",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: AppValues.fs24,
            ),
            maxLines: 1,
          ),

          SizedBox(height: AppValues.s18),

          AutoSizeText(
            viewModel.currentQuestion ?? "Not available",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppValues.fs28,
            ),
            maxLines: 1,
          ),

          SizedBox(height: AppValues.s4),

          Text(
            viewModel.currentTranslation ?? "Not available",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: AppValues.fs20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
