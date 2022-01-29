import 'package:sqflite/sqflite.dart';

import '../models/http_request_model.dart';
import '../models/http_response_model.dart';
import 'log_datasource.dart';

class LogDatasourceImpl implements LogDatasource {
  final Database database;
  LogDatasourceImpl({
    required this.database,
  });

  @override
  Future<bool> logHttpRequest({
    required HttpRequestModel httpRequestModel,
  }) async {
    var id = await database.insert(
      HttpRequestModel.tableName,
      httpRequestModel.toJson(),
    );
    return (id != 0);
  }

  @override
  Future<bool> logHttpResponse({
    required HttpResponseModel httpResponseModel,
  }) async {
    var id = await database.insert(
      HttpResponseModel.tableName,
      httpResponseModel.toJson(),
    );
    return (id != 0);
  }

  @override
  Future<List<HttpRequestModel>?> httpRequests({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  }) async {
    List<Map<String, Object?>> rows = await database.query(
      HttpRequestModel.tableName,
    );
    var models = List<HttpRequestModel>.from(
      rows.map(
        (row) => HttpRequestModel.fromJson(row),
      ),
    );
    return models;
  }

  @override
  Future<List<HttpResponseModel>?> httpResponses({
    int? requestHashCode,
  }) async {
    List<Map<String, Object?>> rows = await database.query(
      HttpResponseModel.tableName,
    );
    var models = List<HttpResponseModel>.from(
      rows.map(
        (row) => HttpResponseModel.fromJson(row),
      ),
    );
    return models;
  }
}
