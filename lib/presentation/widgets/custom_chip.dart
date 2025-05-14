import 'package:flutter/material.dart';

import '../../utilities/app_values.dart';
import '../../utilities/extensions/build_context_extensions.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.selected,
    required this.label,
    required this.onSelected,
  });

  final bool selected;
  final String label;
  final Function(bool) onSelected;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      selected: selected,
      onSelected: onSelected,
      label: Text(label,
        style: TextStyle(color: context.colorScheme.onPrimaryContainer),
      ),
      side: BorderSide(color: context.colorScheme.surfaceContainerHigh),
      backgroundColor: context.colorScheme.surfaceContainerHigh,
      selectedColor: context.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppValues.r24))),
      showCheckmark: false,
    );
  }
}