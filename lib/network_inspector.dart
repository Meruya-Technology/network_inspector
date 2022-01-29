library network_inspector;

/// Export section
export 'network_inspector_common.dart';
export 'network_inspector_infrastructure.dart';
export 'network_inspector_presentation.dart';

import 'package:network_inspector/domain/entities/http_request.dart';
import 'package:network_inspector/domain/entities/http_response.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';
import 'package:network_inspector/domain/usecases/log_http_request.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource_impl.dart';
import 'package:network_inspector/infrastructure/repositories/log_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

import 'domain/usecases/log_http_response.dart';

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
  LogHttpRequest? logHttpRequest;
  LogHttpResponse? logHttpResponse;

  Future<void> injectDependencies() async {
    database = await DatabaseHelper.connect();
    logDatasource = LogDatasourceImpl(
      database: database!,
    );
    logRepository = LogRepositoryImpl(
      logDatasource: logDatasource!,
    );
    logHttpRequest = LogHttpRequest(
      logRepository: logRepository!,
    );
    logHttpResponse = LogHttpResponse(
      logRepository: logRepository!,
    );
  }

  Future<bool?> writeHttpRequestLog(HttpRequest param) async {
    return await logHttpRequest?.execute(param);
  }

  Future<bool?> writeHttpResponseLog(HttpResponse param) async {
    return await logHttpResponse?.execute(param);
  }
}
