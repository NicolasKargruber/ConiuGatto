import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class CounterButton extends StatefulWidget {
  const CounterButton({super.key, required this.value, required this.onChanged});
  final int value;
  final Function(int) onChanged;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int _counter = 0;

  @override
  void initState() {
    _counter = widget.value;
    super.initState();
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    widget.onChanged(_counter);
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
    widget.onChanged(_counter);
  }

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
              onPressed: _decrement,
              icon: Icon(Icons.remove, color: context.colorScheme.onPrimaryContainer),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(AppValues.r12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: AppValues.p12, vertical: AppValues.p8),
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: AppValues.fs16, color: context.colorScheme.onSurface),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: IconButton(
              onPressed: _increment,
              icon: Icon(Icons.add, color: context.colorScheme.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}