import 'package:flutter/material.dart';

import '../../utilities/extensions/build_context_extensions.dart';
import '../models/quizzed_question.dart';

extension QuizzedQuestionListLabels on List<QuizzedQuestion> {
  String getDaysAgoLabel(BuildContext context) {
    final date = isNotEmpty ? DateUtils.dateOnly(first.date) : null;
    final daysAgo = date != null ? DateTime.now().difference(date).inDays : null;
    switch (daysAgo) {
      case null:
        return context.localization.never;
      case 0:
        return context.localization.today;
      case 1:
        return context.localization.yesterday;
      default:
        return context.localization.daysAgo(daysAgo);
    }
  }
}