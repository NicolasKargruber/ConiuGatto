import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/verb_dto.dart';

final _logTag = (VerbRepository).toString();

class VerbRepository {
  final _remoteUrl = 'https://raw.githubusercontent.com/NicolasKargruber/ConiuGatto-Verbs/main/coniugatto_verbs.json';

  // TODO to separate file
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/verbs.json');
  }


  // TODO to separate file
  // Load JSON from local file
  Future<Map<String, dynamic>?> _readLocalJson() async {
    debugPrint("$_logTag | _readLocalJson() started");
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      return await compute(json.decode, content) as Map<String, dynamic>;
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      return null;
    } finally {
      debugPrint("$_logTag | _readLocalJson() ended");
    }
  }

  // TODO to separate file
  // Write JSON to local file
  Future<void> _writeJsonLocally(Map<String, dynamic> data) async {
    debugPrint("$_logTag | _writeJsonLocally() started");
    final file = await _localFile;
    final jsonString = json.encode(data);
    await file.writeAsString(jsonString);
    debugPrint("$_logTag | _writeJsonLocally() ended");
  }

  /// Public: Load JSON data from cache or fallback
  Future<List<VerbDTO>> loadVerbs() async {
    debugPrint("$_logTag | loadVerbs() started");
    final localJson = await _readLocalJson();
    if (localJson != null) {
      try {
        final jsonList = localJson["verbs"] as List<dynamic>;
        return jsonList.map((json) => VerbDTO.fromJson(json)).toList();
      } on Exception catch (e) {
        debugPrint("$_logTag | Caught exception: $e");
        rethrow;
      } finally {
        debugPrint("$_logTag | loadVerbs() ended");
      }
    }
    // Fallback: copy from asset
    return _loadFromAssets();
  }

  Future<Map<String, dynamic>?> _fetchRemoteJson() async {
    debugPrint("$_logTag | _fetchRemoteJson() started");
    try {
      final remoteResponse = await http.get(Uri.parse(_remoteUrl));
      if (remoteResponse.statusCode == 200) {
        final remoteJson = json.decode(remoteResponse.body);
        return remoteJson;
      }
      throw Exception('${remoteResponse.statusCode} | ${remoteResponse.body}');
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      return null;
    } finally {
      debugPrint("$_logTag | _fetchRemoteJson() ended");
    }
  }

  /// Public: Fetch remote JSON if newer, otherwise use local copy
  Future<List<VerbDTO>> loadOrUpdateVerbs() async {
    debugPrint("$_logTag | loadOrUpdateVerbs() started");
    final remoteJson = await _fetchRemoteJson();
    if(remoteJson != null) {
      try {
        final double remoteVersion = remoteJson['meta']['version'];
        debugPrint('$_logTag | Remote version: $remoteVersion');

        final List<dynamic> jsonList;

        final localJson = await _readLocalJson();
        final double localVersion = localJson?['meta']?['version'] ?? -1;

        if(localJson != null && remoteVersion <= localVersion) {
          debugPrint('$_logTag | Local version: $localVersion');
          jsonList = localJson["verbs"];

        } else {
          debugPrint('$_logTag | Updating local JSON with remote version $remoteVersion');
          await _writeJsonLocally(remoteJson);
          jsonList = remoteJson["verbs"];
        }

        final verbDTOs = jsonList.map((json) => VerbDTO.fromJson(json)).toList();
        return verbDTOs;
      } on Exception catch (e) {
        debugPrint("$_logTag | Caught exception: $e");
        rethrow;
      } finally {
        debugPrint("$_logTag | loadOrUpdateVerbs() ended");
      }
    }

    return loadVerbs();
  }

  Future<List<VerbDTO>> _loadFromAssets() async {
    debugPrint("$_logTag | _loadFromAssets() started");
    try {
      debugPrint("$_logTag | Load json ...");
      final String response = await rootBundle.loadString('assets/data/verbs.json');
      final data = await compute(json.decode, response) as List<dynamic>;
      final verbDTOs = data.map((json) => VerbDTO.fromJson(json)).toList();
      return verbDTOs;
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | _loadFromAssets() ended");
    }
  }
}