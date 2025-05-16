
import 'package:flutter/foundation.dart';

import '../../data/repository/quizzed_question_repository.dart';
import '../../data/repository/verb_repository.dart';
import '../models/question.dart';
import '../models/quizzed_question.dart';
import '../models/verb.dart';
import 'service.dart';

class HistoryService extends Service {
  static final _logTag = (HistoryService).toString();
  // TODO use GetIt
  late final QuizzedQuestionRepository _quizzedQuestionRepository;
  List<QuizzedQuestion> _quizzedQuestions = [];
  List<QuizzedQuestion> get quizzedQuestions => _quizzedQuestions;

  @override
  Future initialize() async {
    _quizzedQuestionRepository = await QuizzedQuestionRepository.initDB();
    await _loadAll();
  }

  Future _loadAll() async {
    if(isInitialized) return;
    debugPrint("$_logTag | _loadAll() started");
    List<QuizzedQuestion> quizzedQuestions = [];
    try {
      final quizzedQuestionDTOs = await _quizzedQuestionRepository.queryAll();
      quizzedQuestions = quizzedQuestionDTOs.map((dto) => QuizzedQuestion.fromDTO(dto)).toList();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
    } finally {
      debugPrint("$_logTag | _loadAll() ended");
    }
    _quizzedQuestions = quizzedQuestions;
  }

  Future addQuestion(Question question) async {
    if(!isInitialized) return debugPrint("$_logTag | Not initialized yet");
    debugPrint("$_logTag | addQuestion($question) started");
    try {
      final quizzedQuestion = QuizzedQuestion.fromQuestion(question);
      _quizzedQuestions.add(quizzedQuestion);
      await _quizzedQuestionRepository.insert(quizzedQuestion.toDTO());
      notifyListeners();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
    } finally {
      debugPrint("$_logTag | addQuestion($question) ended");
    }
  }
}