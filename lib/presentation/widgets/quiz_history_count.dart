import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';

class QuizHistoryCount extends StatelessWidget {
  const QuizHistoryCount({super.key, required this.negatives, required this.positives});

  final int negatives;
  final int positives;

  static final _tween = Tween<Offset>(
    begin: Offset(0, -1),
    end: Offset.zero,
  );

  static final _duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        AnimatedSwitcher(
          duration: _duration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: _tween.animate(animation),
              child: child,
            );
          },
          child: Text("$negatives",
              key: ValueKey(negatives),
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
          child: Text("$positives",
              key: ValueKey(positives),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs16)
          ),
        ),
        SizedBox(width: AppValues.s2),
        Text("✓", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: AppValues.fs20)),
      ],
    );
  }
}