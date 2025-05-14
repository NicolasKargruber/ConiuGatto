import 'package:flutter/foundation.dart';

import '../../utilities/extensions/string_extensions.dart';
import 'answer_result.dart';
import '../../data/enums/auxiliary.dart';
import '../../data/enums/pronoun.dart';
import 'enums/italian_tense.dart';
import 'tenses/tense.dart';
import 'verb.dart';

class QuizzedQuestion {
  static final _logTag = (QuizzedQuestion).toString();

  final DateTime date;
  final ItalianTense tense;
  final bool wasAnsweredCorrectly;

  QuizzedQuestion({
    required this.date,
    required this.tense,
    required this.wasAnsweredCorrectly,
  });
}