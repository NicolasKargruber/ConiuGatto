import 'package:flutter/material.dart';

import '../models/quizzed_question.dart';

extension QuizzedQuestionListLabels on List<QuizzedQuestion> {
  String get daysAgoLabel {
    final date = isNotEmpty ? DateUtils.dateOnly(first.date) : null;
    final daysAgo = date != null ? DateTime.now().difference(date).inDays : null;
    switch (daysAgo) {
      case null:
        return "Never";
      case 0:
        return "Today";
      case 1:
        return "Yesterday";
      default:
        return "$daysAgo days ago";
    }
  }
}