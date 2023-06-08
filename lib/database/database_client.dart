import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static final DatabaseClient _mInstance = DatabaseClient._internal();
  Database? _matchItDb;
  DatabaseClient._internal();

  static DatabaseClient get instance {
    return _mInstance;
  }

  Database database() {
    if (_matchItDb == null) {
      throw Exception("Not yet called init() method");
    }
    return _matchItDb!;
  }

  Future<void> init() async {
    if (_matchItDb == null) {
      String dbPath = "${await getDatabasesPath()}/database.db";
      _matchItDb = await openDatabase(
        dbPath,
        version: 5,
        //onCreate: _createDb,
        //onUpgrade: _upgradeDb,
        onCreate: (Database db, int newVersion) async {
          for (int version = 0; version < newVersion; version++) {
            await _performDbOperationsVersionWise(db, version + 1);
          }
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          for (int version = oldVersion; version < newVersion; version++) {
            await _performDbOperationsVersionWise(db, version + 1);
          }
        },
      );
    }
  }

  void _createDb(Database db, int version) async {
    debugPrint('Database Version onCreate: $version');
  }

  void _upgradeDb(Database db, int oldVersion, int newVersion) {
    debugPrint('Database Version onUpgrade: OLD: $oldVersion NEW: $newVersion');
  }

  _performDbOperationsVersionWise(Database db, int version) async {
    switch (version) {
      case 1:
        await _databaseVersion1(db);
        break;
      case 2:
        await _databaseVersion2(db);
        break;
      case 3:
        await _databaseVersion3(db);
        break;
      case 4:
        await _databaseVersion4(db);
        break;
      case 5:
        await _databaseVersion5(db);
        break;
    }
  }

  _databaseVersion1(Database db) {
    debugPrint('Database Version: 1');
  }

  _databaseVersion2(Database db) {
    debugPrint('Database Version: 2');
  }

  _databaseVersion3(Database db) {
    debugPrint('Database Version: 3');
  }

  _databaseVersion4(Database db) {
    debugPrint('Database Version: 4');
  }

  _databaseVersion5(Database db) {
    debugPrint('Database Version: 5');
  }
}
