import 'package:flutter/foundation.dart';

import '../../data/models/verb_dto.dart';
import '../../data/repository/verb_repository.dart';
import '../../utilities/connection_helpers.dart' as connection;
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
    debugPrint("$_logTag | initialize()");
    await _loadAll();
  }

  Future _loadAll() async {
    if(isInitialized) return;
    debugPrint("$_logTag | _loadAll() started");
    List<Verb> verbs = [];
    try {
      final List<VerbDTO> verbDTOs;
      if(await connection.hasInternet()) {
        debugPrint("$_logTag | Connected");
        verbDTOs = await _verbRepository.loadOrUpdateVerbs();
      } else {
        debugPrint("$_logTag | Not connected");
        verbDTOs = await _verbRepository.loadVerbs();
      }
      verbs = verbDTOs.map((dto) => Verb.fromDTO(dto)).toList();
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
    } finally {
      debugPrint("$_logTag | _loadAll() ended");
    }
    _verbs = verbs;
    _verbs.sort((a, b) => a.italianInfinitive.compareTo(b.italianInfinitive));
  }
}