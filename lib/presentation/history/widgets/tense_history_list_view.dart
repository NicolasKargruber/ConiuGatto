import 'package:flutter/material.dart';

import '../../../domain/utils/italian_tense_extensions.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/history_view_model.dart';

class TenseHistoryListView extends StatelessWidget {
  const TenseHistoryListView({super.key, required this.quizzedTenses});

  final List<QuizzedTense> quizzedTenses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: quizzedTenses.map((quizzedTense) {
        return ItalianTenseProgressFactory.createCard(
          languageLevelLabel: quizzedTense.tense.level.label,
          title: quizzedTense.tense.fullLabel,
          subtitle: "Last quizzed: ${quizzedTense.daysAgoLabel}",
          progress: quizzedTense.progress,
        );
      }).toList(),
    );
  }
}