library network_inspector;

/// Import section
import 'package:sqflite/sqflite.dart';
import 'common/utils/database_helper.dart';
import 'domain/entities/http_request.dart';
import 'domain/entities/http_response.dart';
import 'domain/repositories/log_repository.dart';
import 'domain/usecases/log_http_request.dart';
import 'domain/usecases/log_http_response.dart';
import 'infrastructure/datasources/log_datasource.dart';
import 'infrastructure/datasources/log_datasource_impl.dart';
import 'infrastructure/repositories/log_repository_impl.dart';

/// Export
export 'presentation/pages/activity_page.dart';

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
