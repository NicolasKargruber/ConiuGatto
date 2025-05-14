import '../models/quizzed_question.dart';

extension QuizzedQuestionListLabels on List<QuizzedQuestion> {
  String get daysAgoLabel {
    final daysAgo = firstOrNull?.date.difference(DateTime.now()).inDays;
    return daysAgo == null ? "Never" : "$daysAgo days ago";
  }
}