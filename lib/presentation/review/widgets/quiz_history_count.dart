import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../view_models/review_view_model.dart';

// TODO separate viewModel from widget (to "ReviewAppBar")
// TODO Move to general widgets
class QuizHistoryCount extends StatelessWidget {
  const QuizHistoryCount({super.key});

  static final _tween = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset.zero,
  );

  static final _duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReviewViewModel>();

    return viewModel.hasQuizzableQuestions ? Row(
      children: [
        AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: _tween.animate(animation),
              child: child,
            );
          },
          child: Text("${viewModel.negativeQuizCount}",
              key: ValueKey(viewModel.negativeQuizCount),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
          ),
        ),
        SizedBox(width: AppValues.s2),
        Text("❌"),
        SizedBox(width: AppValues.s8),
        AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: _tween.animate(animation),
              child: child,
            );
          },
          child: Text("${viewModel.positiveQuizCount}",
              key: ValueKey(viewModel.positiveQuizCount),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
          ),
        ),
        SizedBox(width: AppValues.s2),
        Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: AppValues.fs20)),
      ],
    ) : Spacer();
  }
}