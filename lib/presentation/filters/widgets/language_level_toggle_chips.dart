import 'package:flutter/material.dart';

import '../../../domain/models/enums/language_level.dart';
import '../../../utilities/app_values.dart';

class LanguageLevelChips extends StatelessWidget {
  const LanguageLevelChips({super.key, required this.isSelected, required this.onSelected});

  final bool Function(LanguageLevel) isSelected;
  final Function(bool selected, {required LanguageLevel level}) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: LanguageLevel.values.length,
      separatorBuilder: (context, index) => SizedBox(width: AppValues.s8),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final level = LanguageLevel.values[index];
        return FilterChip(
          label: Text(level.label),
          selected: isSelected(level),
          onSelected: (selected) => onSelected(selected, level: level),
        );
      },
    );
  }
}