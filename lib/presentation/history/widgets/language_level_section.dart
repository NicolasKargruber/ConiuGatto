import 'package:flutter/material.dart';

import '../../../domain/utils/italian_tense_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/history_view_model.dart';
import 'fluency_details_sheet.dart';

class LanguageLevelSection extends StatelessWidget {
  const LanguageLevelSection({super.key, required this.quizzedLevel});

  final QuizzedLanguageLevel quizzedLevel;

  _showFluencyDetailsSheet(BuildContext context, QuizzedTense quizzedTense) async {
    await showModalBottomSheet(context: context, builder: (context) {
      return FluencyDetailsSheet(
        label: quizzedTense.type.fullLabel,
        fluency: quizzedTense.fluency,
        daysAgoLabel: quizzedTense.daysAgoLabel,
        example: quizzedTense.type.example,
        exampleTranslation: quizzedTense.type.exampleTranslation,
        milestonePassed: quizzedTense.fluency >= quizzedTense.milestone,
      );
    });
  }

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
          languageLevelLabel: quizzedTense.type.level.label,
          title: quizzedTense.type.fullLabel,
          subtitle: "Last quizzed: ${quizzedTense.daysAgoLabel}",
          progress: quizzedTense.fluency,
          milestone: quizzedTense.milestone,
          onTap: () => _showFluencyDetailsSheet(context, quizzedTense)
        );
      })
      ],
    );
  }
}