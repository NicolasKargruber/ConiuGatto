import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../models/verb_dto.dart';
import '../utils/verb_data_source.dart';

class VerbRepository {
  static final _logTag = (VerbRepository).toString();

  final _dataSource = GetIt.I<VerbDataSource>();

  /// Public: Load JSON data from cache or fallback
  Future<List<VerbDTO>> loadVerbs() async {
    debugPrint("$_logTag | loadVerbs() started");
    final localJson = await _dataSource.loadLocalJson();
    if (localJson != null) {
      try {
        debugPrint('$_logTag | Local version: ${localJson["meta"]["version"]}');
        final jsonList = localJson["verbs"] as List<dynamic>;
        return jsonList.map((json) => VerbDTO.fromJson(json)).toList();
      } on Exception catch (e) {
        debugPrint("$_logTag | Caught exception: $e");
        rethrow;
      } finally {
        debugPrint("$_logTag | loadVerbs() ended");
      }
    }
    // Fallback: Assets
    return _loadFromAssets();
  }

  Future<List<VerbDTO>> loadOrUpdateVerbs() async {
    debugPrint("$_logTag | loadOrUpdateVerbs() started");
    final updatedJson = await _dataSource.loadAndUpdateJson();
    if(updatedJson != null) {
      try {
        final verbDTOs = updatedJson.map((json) => VerbDTO.fromJson(json)).toList();
        return verbDTOs;
      } on Exception catch (e) {
        debugPrint("$_logTag | Caught exception: $e");
        rethrow;
      } finally {
        debugPrint("$_logTag | loadOrUpdateVerbs() ended");
      }
    }
    // Fallback: Local cache
    return loadVerbs();
  }

  Future<List<VerbDTO>> _loadFromAssets() async {
    debugPrint("$_logTag | _loadFromAssets() started");
    try {
      final data = await _dataSource.loadJsonFromAssets();
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