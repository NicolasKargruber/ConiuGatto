import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/quiz_view_model.dart';

class QuizContent extends StatelessWidget {
  const QuizContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuizViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  48.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(viewModel.isDoubleAuxiliary)
              Chip(label: Text("${viewModel.currentAuxiliary?.name.toUpperCase()}")),
            SizedBox(height: 4),
            AutoSizeText(
              viewModel.currentTitle ?? "Not available",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
              maxLines: 1,
            ),

            SizedBox(height: 18),

            AutoSizeText(
              viewModel.currentQuestion ?? "Not available",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 28,
              ),
              maxLines: 1,
            ),

            SizedBox(height: 4),

            Text(
              viewModel.currentTranslation ?? "Not available",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
