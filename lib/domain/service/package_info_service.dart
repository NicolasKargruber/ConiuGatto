import 'package:flutter/foundation.dart';

import '../../data/repository/package_info_repository.dart';
import 'service.dart';

// TODO Move using GetIt
class PackageInfoService extends Service {
  static final _logTag = (PackageInfoService).toString();

  late final PackageInfoRepository _packageInfoRepository;

  PackageInfoService();

  @override
  Future initialize() async {
    debugPrint("$_logTag | initialize()");
    _packageInfoRepository = await PackageInfoRepository.initialize();
  }

  String? get appName => isInitialized ? _packageInfoRepository.appName : null;
  String? get packageName => isInitialized ? _packageInfoRepository.packageName : null;
  String? get version => isInitialized ? _packageInfoRepository.version : null;
  String? get buildNumber => isInitialized ? _packageInfoRepository.buildNumber : null;
}
