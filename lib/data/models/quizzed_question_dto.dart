import '../enums/italian_tense.dart';

class QuizzedQuestionDTO {
  final int? id;
  final DateTime date;
  final ItalianTense tense;
  final bool correct;

  QuizzedQuestionDTO({
    this.id,
    required this.date,
    required this.tense,
    required this.correct,
  });

  factory QuizzedQuestionDTO.fromMap(Map<String, dynamic> json) => QuizzedQuestionDTO(
    id: json["id"] as int,
    date: DateTime.parse(json["date"] as String),
    tense: ItalianTense.fromJson(json["tense"] as String),
    correct: json["correct"] as int == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date.toString(),
    "tense": tense.toString(),
    "correct": correct,
  };

  @override
  String toString() {
    return 'QuizzedQuestionDTO{id: $id, date: $date, tense: $tense, correct:$correct}';
  }
}