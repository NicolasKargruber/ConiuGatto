import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({super.key, required this.value, required this.increment, required this.decrement});

  final int value;
  final Function()? increment;
  final Function()? decrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppValues.p0),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppValues.r24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: decrement,
              icon: Icon(Icons.remove, color: context.colorScheme.onPrimaryContainer),
              style: ElevatedButton.styleFrom(disabledBackgroundColor: context.colorScheme.surfaceContainer),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.r12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p12, vertical: AppValues.p8),
            child: Text(
              '$value',
              style: TextStyle(fontSize: AppValues.fs16, color: context.colorScheme.onSurface),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: increment,
              icon: Icon(Icons.add, color: context.colorScheme.onPrimaryContainer),
              style: ElevatedButton.styleFrom(disabledBackgroundColor: context.colorScheme.surfaceContainer),
            ),
          ),
        ],
      ),
    );
  }
}