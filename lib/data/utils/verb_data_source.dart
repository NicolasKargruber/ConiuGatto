
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class VerbDataSource {
  static final _logTag = (VerbDataSource).toString();

  final _httpClient = GetIt.I<http.Client>();
  final _localFile =  GetIt.I<LocalVerbsFile>();

  final _remoteUrl = 'https://raw.githubusercontent.com/NicolasKargruber/ConiuGatto-Verbs/main/coniugatto_verbs.json';
  final _assetPath = 'assets/data/verbs.json';

  Future<Map<String, dynamic>?> loadLocalJson() async {
    debugPrint("$_logTag | readJson() started");
    try {
      final file = await _localFile.instance;
      final content = await file.readAsString();
      return await compute(json.decode, content) as Map<String, dynamic>;
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      return null;
    } finally {
      debugPrint("$_logTag | readJson() ended");
    }
  }

  /// Write JSON to local file
  Future<void> writeLocalJson(Map<String, dynamic> data) async {
    debugPrint("$_logTag | writeLocalJson() started");
    final file = await _localFile.instance;
    final jsonString = json.encode(data);
    await file.writeAsString(jsonString);
    debugPrint("$_logTag | writeLocalJson() ended");
  }

  Future<Map<String, dynamic>?> loadRemoteJson() async {
    debugPrint("$_logTag | loadRemoteJson() started");
    try {
      final remoteResponse = await _httpClient.get(Uri.parse(_remoteUrl));
      if (remoteResponse.statusCode == 200) {
        return json.decode(remoteResponse.body);
      }
      throw Exception('${remoteResponse.statusCode} | ${remoteResponse.body}');
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      return null;
    } finally {
      debugPrint("$_logTag | loadRemoteJson() ended");
    }
  }

  /// Public: Fetch remote JSON if newer, otherwise use local copy
  Future<List<dynamic>?> loadAndUpdateJson() async {
    debugPrint("$_logTag | loadAndUpdateJson() started");
    final remoteJson = await loadRemoteJson();
    if(remoteJson == null) return null;

    try {
      final double remoteVersion = remoteJson['meta']['version'];
      debugPrint('$_logTag | Remote version: $remoteVersion');

      final localJson = await loadLocalJson();
      final double? localVersion = localJson?['meta']?['version'];
      debugPrint('$_logTag | Local version: $localVersion');

      if (localJson != null && remoteVersion <= (localVersion ?? -1)) {
        debugPrint('$_logTag | Using local JSON');
        return localJson["verbs"];
      } else {
        debugPrint('$_logTag | Updating local JSON with remote version $remoteVersion');
        await writeLocalJson(remoteJson);
        return remoteJson["verbs"];
      }
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      return null;
    } finally {
      debugPrint("$_logTag | loadAndUpdateJson() ended");
    }
  }

  Future<List<dynamic>> loadJsonFromAssets() async {
    debugPrint("$_logTag | loadJsonFromAssets() started");
    try {
      debugPrint("$_logTag | Load json ...");
      final data = await rootBundle.loadString(_assetPath);
      return json.decode(data) as List<dynamic>;
    } catch (e) {
      debugPrint("$_logTag | Error loading from assets: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | loadJsonFromAssets() ended");
    }
  }
}

class LocalVerbsFile {
  final _fileName = 'coniugatto_verbs.json';

  Future<File> get instance async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }
}
