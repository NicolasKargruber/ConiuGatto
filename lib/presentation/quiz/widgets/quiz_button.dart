import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../widgets/shake_widget.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({super.key, required this.onPressed, required this.shakeKey});

  final Function() onPressed;
  final GlobalKey shakeKey;

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      key: shakeKey,
      child: FilledButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppValues.p8),
          child: Text("Check", style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs24),
          ),
        ),
      ),
    );
  }
}
