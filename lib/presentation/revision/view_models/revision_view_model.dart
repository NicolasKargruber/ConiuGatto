import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../../../data/enums/pronoun.dart';
import '../../../domain/models/answer_result.dart';
import '../../../data/enums/italian_tense.dart';
import '../../../domain/models/enums/verb_favourite_filter.dart';
import '../../../domain/models/question.dart';
import '../../../domain/models/quizzed_question.dart';
import '../../../domain/models/verb.dart';
import '../../../domain/service/history_service.dart';
import '../../../domain/service/shared_preference_service.dart';
import '../../../domain/utils/filter_extensions.dart';
import '../../../domain/utils/url_helper.dart';
import '../../../utilities/extensions/iterable_extensions.dart';
import '../../view_model.dart';

class RevisionViewModel extends ViewModel {
  static final _logTag = (RevisionViewModel).toString();

  final List<Question> _questions;
  List<Question> get questions => _questions;

  RevisionViewModel(this._questions);

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
  }
}
