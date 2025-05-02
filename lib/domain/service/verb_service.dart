
import 'package:flutter/foundation.dart';

import '../../data/repository/verb_repository.dart';
import '../models/verb.dart';
import 'service.dart';

final _logTag = (VerbService).toString();

class VerbService extends Service {
  // TODO use GetIt
  final VerbRepository _verbRepository = VerbRepository();
  List<Verb> _verbs = [];
  List<Verb> get verbs => _verbs;

  @override
  Future initialize() async {
    _verbs = await loadAll();
  }

  Future loadAll() async {
    if(isInitialized) return;
    debugPrint("$_logTag | loadAll() started");
    List<Verb> verbs = [];
    try {
      final verbDTOs = await _verbRepository.getAll();
      verbs = verbDTOs.map((dto) => Verb.fromDTO(dto)).toList();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
    } finally {
      debugPrint("$_logTag | loadAll() ended");
    }
    return verbs;
  }
}