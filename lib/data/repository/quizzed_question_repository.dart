import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../enums/auxiliary.dart';
import '../enums/pronoun.dart';
import '../models/quizzed_question_dto.dart';

const _databaseName = "SqfliteDB.db";

class QuizzedQuestionRepository {
  static final _logTag = (QuizzedQuestionRepository).toString();
  static const _version = 2;
  static const _tableName = "quizzed_question";

  final Database _database;

  QuizzedQuestionRepository._(this._database);

  static initDB() async {
    debugPrint("$_logTag | initDB() started");
    final Database database;
    try {
      debugPrint("$_logTag | Initialize Database ...");
      String path = join(await getDatabasesPath(), _databaseName);
      database = await openDatabase(path, version: _version,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $_tableName ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "date TEXT,"
              "verbID TEXT,"
              "pronoun INTEGER,"
              "auxiliary INTEGER,"
              "tense INTEGER,"
              "correct BIT"
              ")");
          debugPrint("$_logTag | Created table ...");
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (oldVersion < _version) {
            // Migration from version 1 to 2
            await db.execute('''
              ALTER TABLE $_tableName 
              ADD COLUMN verbID TEXT DEFAULT ''
            ''');
            await db.execute('''
              ALTER TABLE $_tableName 
              ADD COLUMN pronoun INTEGER DEFAULT '${Pronoun.firstSingular.jsonKey}'
            ''');
            await db.execute('''
              ALTER TABLE $_tableName 
              ADD COLUMN auxiliary INTEGER DEFAULT '${Auxiliary.avere.jsonKey}'
            ''');
          }
          debugPrint("$_logTag | Migrated table from version $oldVersion to $newVersion ...");
        },
      );
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | initDB() ended");
    }
    return QuizzedQuestionRepository._(database);
  }

  // Define a function that inserts dogs into the database
  Future<void> insert(QuizzedQuestionDTO quizzedQuestion) async {
    debugPrint("$_logTag | insert() started");
    debugPrint("$_logTag | QuizzedQuestion: $quizzedQuestion");
    try {
      debugPrint("$_logTag | Insert ...");
      await _database.insert(_tableName,
        quizzedQuestion.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | insert() ended");
    }
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<QuizzedQuestionDTO>> queryAll() async {
    debugPrint("$_logTag | queryAll() started");
    List<QuizzedQuestionDTO> quizzedQuestionDTOs = [];
    try {
      debugPrint("$_logTag | Query data ...");
      final List<Map<String, Object?>> maps = await _database.query(_tableName);
      quizzedQuestionDTOs = maps.map((map) => QuizzedQuestionDTO.fromMap(map)).toList();
      if(quizzedQuestionDTOs.length > 2) {
        debugPrint("$_logTag | Found quizzed questions: [${quizzedQuestionDTOs.firstOrNull.toString()}, ... , ${quizzedQuestionDTOs.lastOrNull.toString()}]");
      }
      else {
        debugPrint("$_logTag | Found quizzed questions: $quizzedQuestionDTOs");
      }
    } on Exception catch (e) {
      debugPrint("$_logTag | Caught exception: $e");
      rethrow;
    } finally {
      debugPrint("$_logTag | queryAll() ended");
    }
    return quizzedQuestionDTOs;
  }
}