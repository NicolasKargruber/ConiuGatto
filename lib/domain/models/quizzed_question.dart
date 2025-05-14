import '../../data/enums/italian_tense.dart';
import '../../data/models/quizzed_question_dto.dart';
import 'question.dart';

class QuizzedQuestion {
  final DateTime date;
  final ItalianTense tense;
  final bool correct;

  QuizzedQuestion({
    required this.date,
    required this.tense,
    required this.correct,
  });

  factory QuizzedQuestion.fromDTO(QuizzedQuestionDTO dto) {
    return QuizzedQuestion(
      date: dto.date,
      tense: dto.tense,
      correct: dto.correct,
    );
  }

  factory QuizzedQuestion.fromQuestion(Question question) {
    return QuizzedQuestion(
      date: DateTime.now(),
      tense: question.tense.type,
      correct: question.isCorrect,
    );
  }

  QuizzedQuestionDTO toDTO() {
    return QuizzedQuestionDTO(
      date: date,
      tense: tense,
      correct: correct,
    );
  }
}