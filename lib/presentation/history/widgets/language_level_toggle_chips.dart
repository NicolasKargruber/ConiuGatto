import 'package:flutter/material.dart';

import '../../../domain/models/enums/language_level.dart';
import '../../../utilities/app_values.dart';
import '../../widgets/custom_chip.dart';

class LanguageLevelChoiceChips extends StatelessWidget {
  const LanguageLevelChoiceChips({
    super.key,
    required this.value,
    required this.onSelected,
  });

  final LanguageLevel value;
  final Function(LanguageLevel) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: LanguageLevel.values.length,
      separatorBuilder: (context, index) => SizedBox(width: AppValues.s12),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final level = LanguageLevel.values[index];
        return CustomChip(
          label: level.label,
          onSelected: (selected) {
            if(selected) onSelected(level);
          },
          selected: level == value,
        );
      },
    );
  }
}