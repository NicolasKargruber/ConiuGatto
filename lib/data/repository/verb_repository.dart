import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/verb_dto.dart';

final _logTag = (VerbRepository).toString();

class VerbRepository {
  Future<List<VerbDTO>> getAll() async {
    debugPrint("$_logTag | getAll() started");
    List<VerbDTO> verbDTOs = [];
    try {
      debugPrint("$_logTag | Load json ...");
      final String response = await rootBundle.loadString('assets/data/verbs.json');
      final data = await compute(json.decode, response) as List<dynamic>;
      verbDTOs = data.map((json) => VerbDTO.fromJson(json)).toList();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | getAll() ended");
    }
    return verbDTOs;
  }
}