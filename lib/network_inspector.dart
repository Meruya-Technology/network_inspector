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

/// This class is called in multiple place, first it's needed to called on the
/// initial phase of the application in order to initialized the local database
/// for http activities log
///
/// ```dart
/// NetworkInspector.initialize();
/// ```
///
/// Then it's needed for invoked to network interceptors constructor
/// Dio example
///
/// ```dart
/// Dio(
///   BaseOptions(
///     baseUrl: 'http://192.168.1.6:8000/',
///     connectTimeout: 10 * 1000, // 10 second
///     headers: {
///       'Content-type': 'application/json',
///       'Accept': 'application/json',
///       'Authorization': 'Bearer i109gh23j9u1h3811io2n391'
///     },
///   ),
/// )..interceptors.add(
///   DioInterceptor(
///     logIsAllowed: true,
///     networkInspector: networkInspector,
///     onHttpFinish: (hashCode, title, message) {
///       notifyActivity(
///         title: title,
///         message: message,
///       );
///     },
///   ),
/// )
/// ```
/// Http example
/// ```dart
/// HttpInterceptor(
///   logIsAllowed: true,
///   client: client,
///   baseUrl: Uri.parse('http://192.168.1.3:8000/'),
///   networkInspector: networkInspector,
///   onHttpFinish: (hashCode, title, message) {
///     notifyActivity(
///       title: title,
///       message: message,
///     );
///   },
///   headers: {
///     'Content-type': 'application/json',
///     'Accept': 'application/json',
///     'Authorization': 'Bearer WEKLSSS'
///   },
/// );
/// ```
class NetworkInspector {
  NetworkInspector() {
    /// when this class is called, it will called the dependencies first
    injectDependencies();
  }

  /// Call this method on the main initialization
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

  /// writeHttpRequestLog is used to log http request data,
  Future<bool?> writeHttpRequestLog(HttpRequest param) async {
    return await logHttpRequest?.execute(param);
  }

  /// writeHttpResponseLog is used to log http response data
  Future<bool?> writeHttpResponseLog(HttpResponse param) async {
    return await logHttpResponse?.execute(param);
  }
}
