import '../../data/enums/italian_tense.dart';
import '../../data/models/quizzed_question_dto.dart';

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

  QuizzedQuestionDTO toDTO() {
    return QuizzedQuestionDTO(
      date: date,
      tense: tense,
      correct: correct,
    );
  }
}