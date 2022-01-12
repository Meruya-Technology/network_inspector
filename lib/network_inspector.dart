library network_inspector;

/// Export section
export 'network_inspector_common.dart';
export 'network_inspector_infrastructure.dart';
export 'network_inspector_presentation.dart';

import 'package:network_inspector/domain/repositories/log_repository.dart';
import 'package:network_inspector/domain/usecases/log_activity.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource_impl.dart';
import 'package:network_inspector/infrastructure/repositories/log_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

/// Import section
import 'network_inspector_common.dart';

/// Core class section
class NetworkInspector {
  NetworkInspector() {
    /// when this class is called, it will called the dependencies first
    injectDependencies();
  }

  /// Database need to be initialize first before we can use another
  /// NetworkInspector properties
  static Future<void> initialize() async {
    await DatabaseHelper.initialize();
  }

  /// Dependency injection
  Database? database;
  LogDatasource? logDatasource;
  LogRepository? logRepository;
  LogActivity? logActivity;

  Future<void> injectDependencies() async {
    database = await DatabaseHelper.connect();
    logDatasource = LogDatasourceImpl(
      database: database!,
    );
    logRepository = LogRepositoryImpl(
      logDatasource: logDatasource!,
    );
    logActivity = LogActivity(
      logRepository: logRepository!,
    );
  }

  Future<bool?> log(LogActivityParam param) async {
    return await logActivity?.execute(
      param,
    );
  }
}
