import 'package:flutter/material.dart';

import '../../../domain/utils/italian_tense_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/history_view_model.dart';

class LanguageLevelSection extends StatelessWidget {
  const LanguageLevelSection({super.key, required this.quizzedLevel});

  final QuizzedLanguageLevel quizzedLevel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LanguageLevelProgressFactory.createLabeledCircularProgressIndicator(
          label: quizzedLevel.type.label,
          progress: quizzedLevel.progress,
        ),

        ...quizzedLevel.quizzedTenses.map((quizzedTense) {
        return ItalianTenseProgressFactory.createCard(
          languageLevelLabel: quizzedTense.tense.level.label,
          title: quizzedTense.tense.fullLabel,
          subtitle: "Last quizzed: ${quizzedTense.daysAgoLabel}",
          progress: quizzedTense.progress,
          milestone: quizzedTense.milestone
        );
      })
      ],
    );
  }
}