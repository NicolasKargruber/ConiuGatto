import 'package:flutter/material.dart';

import '../../../domain/utils/italian_tense_extensions.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/tenses_view_model.dart';
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
        exampleTranslation: quizzedTense.type.getExampleTranslation(context),
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
          // TODO translate
          subtitle: "${context.localization.lastQuizzedLabel} ${quizzedTense.daysAgoLabel}",
          progress: quizzedTense.fluency,
          milestone: quizzedTense.milestone,
          onTap: () => _showFluencyDetailsSheet(context, quizzedTense)
        );
      })
      ],
    );
  }
}