import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/enums/mood.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../about/screens/about_screen.dart';
import '../../quiz/screens/quiz_screen.dart';
import '../view_models/tenses_view_model.dart';
import '../../filters/widgets/language_level_toggle_chips.dart';
import '../widgets/language_level_section.dart';
import '../widgets/quiz_length_sheet.dart';

class TensesScreen extends StatelessWidget {
  static final _logTag = (TensesScreen).toString();
  const TensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TensesViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.tensesAppTitle),
        actions: [
          IconButton(onPressed: () => AboutScreen.show(context), icon: Icon(Icons.settings_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppValues.p4),
        child: Column(
          children: [
            if(viewModel.hasIncorrectQuestion) Padding(
              padding: const EdgeInsets.fromLTRB(AppValues.p8, AppValues.p8, AppValues.p8, AppValues.p12),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppValues.p8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppValues.p20, vertical: AppValues.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.localization.quizIncorrectLabel, style: TextStyle(color: context.colorScheme.onPrimaryContainer)),
                    FilledButton(child: Text(context.localization.start), onPressed: () {
                      QuizLengthSheet.show(context,
                        showQuizScreen: (length) =>
                            QuizScreen.show(context,
                                quizzableQuestions: viewModel.latestIncorrectQuestions,
                                quizLength: length,
                            ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            Flexible(
              child: ListView(
                clipBehavior: Clip.hardEdge,
                children: [
                  LanguageLevelSection(
                    quizzedLevel: viewModel.quizzedLevelA1,
                  ),

                  LanguageLevelSection(
                    quizzedLevel: viewModel.quizzedLevelA2,
                  ),

                  LanguageLevelSection(
                    quizzedLevel: viewModel.quizzedLevelB1,
                  ),

                  LanguageLevelSection(
                    quizzedLevel: viewModel.quizzedLevelB2,
                  ),

                  LanguageLevelSection(
                    quizzedLevel: viewModel.quizzedLevelC1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

