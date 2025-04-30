import 'package:flutter/material.dart';

import '../data/app_values.dart';
import 'shake_widget.dart';

class ShakeableCheckButton extends StatelessWidget {
  const ShakeableCheckButton({super.key, required this.onPressed, required this.shakeKey});

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
    );;
  }
}
