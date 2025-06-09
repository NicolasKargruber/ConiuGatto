import 'package:flutter/foundation.dart';

import '../../../domain/service/shared_preference_service.dart';
import '../../view_model.dart';

class SplashViewModel extends ViewModel {
  static final _logTag = (SplashViewModel).toString();

  final SharedPreferenceService _preferenceService;

  SplashViewModel(this._preferenceService);

  bool isSkipIntroduction = false;

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    await _preferenceService.initializationFuture;
    isSkipIntroduction = _preferenceService.loadSkipIntroductionPref();
    // Debug
    if(!kReleaseMode) isSkipIntroduction = false;
  }

  void skipIntroduction() {
    debugPrint("$_logTag | skipIntroduction()");
    isSkipIntroduction = true;
    _preferenceService.setSkipIntroductionPrefToTrue();
    notifyListeners();
  }
}