import '../../data/enums/auxiliary.dart';
import '../../data/enums/italian_tense.dart';
import '../../data/enums/pronoun.dart';
import '../../data/models/quizzed_question_dto.dart';
import 'question.dart';

class QuizzedQuestion {
  final DateTime date;
  final String? verbID;
  final Pronoun pronoun;
  final Auxiliary auxiliary;
  final ItalianTense tense;
  final bool correct;

  QuizzedQuestion({
    required this.date,
    required this.verbID,
    required this.pronoun,
    required this.auxiliary,
    required this.tense,
    required this.correct,
  });

  factory QuizzedQuestion.fromDTO(QuizzedQuestionDTO dto) {
    return QuizzedQuestion(
      date: dto.date,
      verbID: dto.verbID.isNotEmpty ? dto.verbID : null,
      pronoun: dto.pronoun,
      auxiliary: dto.auxiliary,
      tense: dto.tense,
      correct: dto.correct,
    );
  }

  factory QuizzedQuestion.fromQuestion(Question question) {
    return QuizzedQuestion(
      date: DateTime.now(),
      verbID: question.verb.id,
      pronoun: question.pronoun,
      auxiliary: question.auxiliary,
      tense: question.tense.type,
      correct: question.isCorrect,
    );
  }

  QuizzedQuestionDTO toDTO() {
    return QuizzedQuestionDTO(
      date: date,
      verbID: verbID ?? '',
      pronoun: pronoun,
      auxiliary: auxiliary,
      tense: tense,
      correct: correct,
    );
  }

  @override
  String toString() {
    return 'QuizzedQuestion{date: $date, verbID: $verbID, pronoun: $pronoun, auxiliary: $auxiliary, tense: $tense, correct:$correct}';
  }
}