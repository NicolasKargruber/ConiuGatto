import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/language_level.dart';
import '../../../domain/models/quizzed_question.dart';
import '../../../domain/service/history_service.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/language_level_extensions.dart';
import '../../../domain/utils/quizzed_question_extensions.dart';
import '../../view_model.dart';

class QuizLengthViewModel extends ViewModel {
  static final _logTag = (QuizLengthViewModel).toString();

  @override
  Future initialize() async {}

  int _quizLength = 5;
  int get quizLength => _quizLength;
  Function()? get increment => _quizLength < 50 ? _increment : null;
  Function()? get decrement => _quizLength > 5 ? _decrement : null;

  void _increment() {
    _quizLength+=5;
    notifyListeners();
  }

  void _decrement() {
    _quizLength-=5;
    notifyListeners();
  }
}
