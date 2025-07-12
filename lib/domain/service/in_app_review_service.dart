import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';

import 'service.dart';
import 'shared_preference_service.dart';

class InAppReviewService extends Service {
  static final _logTag = (InAppReviewService).toString();

  final SharedPreferenceService _sharedPreferenceService;

  InAppReviewService(this._sharedPreferenceService);

  late final InAppReview _inAppReview;
  late final int _launchCount;
  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _inAppReview = InAppReview.instance;
    await _sharedPreferenceService.initializationFuture;
    _launchCount = _sharedPreferenceService.loadLaunchCount();
  }

  bool get _showReviewDialog => _launchCount >= 0 && (_launchCount % 5 == 0);

  void _updateLaunchCount() {
    debugPrint("$_logTag | updateLaunchCount()");
    _sharedPreferenceService.updateLaunchCount(_launchCount + 1);
  }

  void maybeRequestReview() async {
    debugPrint("$_logTag | maybeRequestReview()");
    if (await _inAppReview.isAvailable() && _showReviewDialog) _inAppReview.requestReview();
    // Launch Count
    _updateLaunchCount();
  }

  void openStoreListing() {
    debugPrint("$_logTag | openStoreListing()");
    _inAppReview.openStoreListing(appStoreId: "6748058834");
  }
}