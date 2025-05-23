import 'package:flutter/material.dart';

import '../../../utilities/app_values.dart';
import '../../../utilities/widget_factory.dart';
import '../view_models/history_view_model.dart';

class TenseHistoryListView extends StatelessWidget {
  const TenseHistoryListView({super.key, required this.quizzedTenses});

  final List<QuizzedTense> quizzedTenses;

  @override
  Widget build(BuildContext context) {
    if (quizzedTenses.isEmpty) {
      return Center(child: _NoTensesAvailable());
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: AppValues.p16),
      separatorBuilder: (context, index) => SizedBox(height: AppValues.s8),
      itemCount: quizzedTenses.length,
      itemBuilder: (_, index) {
        final quizzedTense = quizzedTenses[index];
        return ItalianTenseProgressFactory.createCard(
          title: quizzedTense.tense.label,
          subtitle: "Last quizzed: ${quizzedTense.daysAgoLabel}",
          progress: quizzedTense.progress,
        );
      },
    );
  }
}

class _NoTensesAvailable extends StatelessWidget {
  const _NoTensesAvailable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppValues.s8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(' No Tenses to review here! 🫙',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppValues.fs20)
        ),

        Text('Choose a higher Language Level'),
      ],
    );
  }
}