import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../infrastructure/models/http_request_model.dart';
import '../../infrastructure/models/http_response_model.dart';
import '../../infrastructure/models/map_to_table.dart';

class DatabaseHelper {
  static const String databaseName = 'network_inspector.db';
  static const int databaseVersion = 2;

  static Future<Database> initialize() async {
    var database = openDatabase(
      databaseName,
      version: databaseVersion,
      onCreate: (Database db, int version) async {
        debugPrint('Database Created');
        await initializeTable(
          database: db,
          version: version,
        );
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('Database Upgrade from version $oldVersion to $newVersion');
        await migrateDatabase(
          database: db,
          oldVersion: oldVersion,
          newVersion: newVersion,
        );
      },
      onConfigure: (Database db) {
        debugPrint('Configuring Database..');
      },
      onOpen: (Database db) {
        debugPrint('Database Open & Connected');
      },
    );
    return database;
  }

  static Future<void> initializeTable({
    required Database database,
    required int version,
  }) async {
    await createTable(
      migrationScript: await HttpRequestModel.migrationWithCurl,
      database: database,
    );
    await createTable(
      migrationScript: await HttpResponseModel.migration,
      database: database,
    );
  }

  static Future<void> migrateDatabase({
    required Database database,
    required int oldVersion,
    required int newVersion,
  }) async {
    debugPrint('Starting database migration from v$oldVersion to v$newVersion');

    if (oldVersion < 2 && newVersion >= 2) {
      await migrateToAddCurlColumn(database);
    }

    // Future migrations can be added here
    // if (oldVersion < 3 && newVersion >= 3) {
    //   await _migrateTo_v3_SomeOtherChange(database);
    // }
  }

  static Future<void> migrateToAddCurlColumn(Database database) async {
    debugPrint('Migrating to v2: Adding cUrl column to http_requests table');

    try {
      final result = await database
          .rawQuery("PRAGMA table_info(${HttpRequestModel.tableName})");

      bool curlColumnExists = result.any((column) => column['name'] == 'cUrl');

      if (!curlColumnExists) {
        await database.execute(
            'ALTER TABLE ${HttpRequestModel.tableName} ADD COLUMN cUrl TEXT');
        debugPrint(
            'Successfully added cUrl column to ${HttpRequestModel.tableName}');
      } else {
        debugPrint(
            'cUrl column already exists in ${HttpRequestModel.tableName}');
      }
    } catch (e) {
      debugPrint('Error during v2 migration: $e');
      rethrow;
    }
  }

  static Future<void> createTable({
    required Database database,
    required Map<String, dynamic> migrationScript,
  }) async {
    /// Initialize query
    debugPrint('Initialize Table');
    var migrationObject = MapToTable.fromJson(migrationScript);
    var definitions = migrationObject.definition;
    var definitionLength = definitions?.length ?? 0;
    var query = '';

    /// DDL Building
    for (var i = 0; i < definitionLength; i++) {
      var definition = definitions?[i];
      if (definition?.fields != null) query += '${definition?.fields}';
      if (definition?.type != null) query += ' ${definition?.type}';
      if (definition?.attribute != null) query += ' ${definition?.attribute}';
      if ((definitionLength - 1) != i) query += ", ";
    }
    var ddl = '''create table ${migrationObject.tableName} ($query)''';

    /// Execute ddl
    await database.execute(ddl).then((_) {
      debugPrint('DDL Executed DDL : $ddl');
    }).onError((error, stackTrace) {
      debugPrint('Error when execute DDL : ${stackTrace.toString()}');
    }).whenComplete(() => close(database));
  }

  static Future<Database> connect() async {
    var database = openDatabase(databaseName);
    return database;
  }

  static Future<void> close(Database database) async {
    await database.close();
  }
}
