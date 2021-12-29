import 'package:flutter/material.dart';
import 'package:network_inspector/infrastructure/models/activity_model.dart';
import 'package:network_inspector/infrastructure/models/map_to_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'network_inspector.db';
  static const int databaseVersion = 1;

  static Future<Database> initialize() async {
    var databasePath = await getDatabasesPath();
    var fullPath = '$databasePath$databaseName';
    var database = openDatabase(
      fullPath,
      version: databaseVersion,
      onCreate: (Database db, int version) async {
        initializeTable(
          database: db,
          version: version,
        );
      },
      onOpen: (Database db) {
        debugPrint('Database opened successfully, path : $fullPath');
      },
    );
    return database;
  }

  static Future<void> initializeTable({
    required Database database,
    required int version,
  }) async {
    createTable(
      migrationScript: await ActivityModel.migration,
      database: database,
    );
  }

  static Future<void> createTable({
    required Database database,
    required Map<String, dynamic> migrationScript,
  }) async {
    var migrationObject = MapToTable.fromJson(migrationScript);
    var definitions = migrationObject.definition;
    var definitionLength = definitions?.length ?? 0;
    var query = '';
    for (var i = 0; i < definitionLength; i++) {
      var definition = definitions?[i];
      query += '${definition?.fields} '
          '${definition?.type} '
          '${definition?.attribute}';
      if ((definitionLength - 1) != i) query += ", ";
    }
    var ddl = '''create table ${migrationObject.tableName} ($query)''';
    await database.execute(ddl).onError((error, stackTrace) {
      debugPrint('Error hen execute ddl : ${stackTrace.toString()}');
    }).whenComplete(() => close(database));
  }

  static Future<void> close(Database database) async {
    await database.close();
  }
}
