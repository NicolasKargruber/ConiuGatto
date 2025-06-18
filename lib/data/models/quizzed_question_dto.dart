import '../enums/auxiliary.dart';
import '../enums/italian_tense.dart';
import '../enums/pronoun.dart';

class QuizzedQuestionDTO {
  final int? id;
  final DateTime date;
  final String verbID;
  final Pronoun pronoun;
  final Auxiliary auxiliary;
  final ItalianTense tense;
  final bool correct;

  QuizzedQuestionDTO({
    this.id,
    required this.date,
    required this.verbID,
    required this.pronoun,
    required this.auxiliary,
    required this.tense,
    required this.correct,
  });

  factory QuizzedQuestionDTO.fromMap(Map<String, dynamic> json) => QuizzedQuestionDTO(
    id: json["id"] as int,
    date: DateTime.parse(json["date"] as String),
    verbID: json["verbID"] as String,
    pronoun: Pronoun.fromJson(json["pronoun"] as String),
    auxiliary: Auxiliary.fromJson(json["auxiliary"] as String),
    tense: ItalianTense.fromJson(json["tense"] as String),
    correct: json["correct"] as int == 1,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date.toString(),
    "verbID": verbID,
    "pronoun": pronoun.jsonKey,
    "auxiliary": auxiliary.jsonKey,
    "tense": tense.jsonKey,
    "correct": correct,
  };

  @override
  String toString() {
    return 'QuizzedQuestionDTO{id: $id, date: $date, verbID: $verbID, pronoun: $pronoun, auxiliary: $auxiliary, tense: $tense, correct:$correct}';
  }
}