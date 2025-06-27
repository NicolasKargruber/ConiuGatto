import 'package:flutter/material.dart';

import '../../../data/enums/italian_tense.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';

class MoodSection extends StatelessWidget {
  static final String _logTag = (MoodSection).toString();

  const MoodSection({super.key,
    required this.label,
    required this.italianTenses,
    required this.onSelectedAll,
    required this.onUnselectedAll,
    required this.onSelectedTense,
    required this.areAllSelected,
    required this.isSelected,
  });

  final String label;
  final List<ItalianTense> italianTenses;
  final Function() onSelectedAll;
  final Function()? onUnselectedAll;
  final Function(bool selected, {required ItalianTense tense}) onSelectedTense;
  final bool areAllSelected;
  final bool Function(ItalianTense) isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: AppValues.p16, vertical: AppValues.p4),
          color: context.colorScheme.surfaceContainerHigh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppValues.fs18),
              ),

              if(onUnselectedAll == null) TextButton(
                onPressed: onSelectedAll,
                child: Text("Select All",
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
              )
              else TextButton(
                onPressed: areAllSelected ? onUnselectedAll : onSelectedAll,
                child: Text("Un-/Select All",
                  style: TextStyle(fontSize: AppValues.fs16),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(AppValues.p12),
          child: Wrap(
            spacing: AppValues.s8,
            children: italianTenses.map((italianTense) => FilterChip(
              label: Text(italianTense.label),
              selected: isSelected(italianTense),
              onSelected: (selected) => onSelectedTense(selected, tense: italianTense),
            )).toList(),
          ),
        )
      ],
    );
  }
}