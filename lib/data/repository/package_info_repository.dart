import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'shared_preference_repository.dart';

// TODO Move using GetIt
class PackageInfoRepository {
  static final _logTag = (PackageInfoRepository).toString();
  final PackageInfo _packageInfo;

  PackageInfoRepository._(this._packageInfo);

  static Future<PackageInfoRepository> initialize() async {
    debugPrint("$_logTag | initialize()");
    return PackageInfoRepository._(await PackageInfo.fromPlatform());
  }

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
}