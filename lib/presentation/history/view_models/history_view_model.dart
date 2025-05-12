import 'package:flutter/foundation.dart';

import '../../../domain/models/enums/language_levels.dart';
import '../../view_model.dart';

class HistoryViewModel extends ViewModel {
  static final _logTag = (HistoryViewModel).toString();

  // Initialized in Parent Constructor
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
  }

  LanguageLevel _selectedLanguageLevel = LanguageLevel.a1;
  LanguageLevel get selectedLanguageLevel => _selectedLanguageLevel;

  selectLanguageLevel(LanguageLevel languageLevel) {
    debugPrint("$_logTag | selectLanguageLevel($languageLevel)");
    _selectedLanguageLevel = languageLevel;
    notifyListeners();
  }

}
