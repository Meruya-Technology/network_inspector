import 'package:sqflite/sqflite.dart';

import '../../network_inspector_infrastructure.dart';
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
    int? requestHashCode,
  }) async {
    List<Map<String, Object?>> rows = await database.query(
      HttpRequestModel.tableName,
      where: 'request_hash_code = ?',
      whereArgs: [requestHashCode],
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
      where: 'request_hash_code = ?',
      whereArgs: [requestHashCode],
    );
    var models = List<HttpResponseModel>.from(
      rows.map(
        (row) => HttpResponseModel.fromJson(row),
      ),
    );
    return models;
  }

  @override
  Future<List<HttpActivityModel>?> httpActivities({
    int? startDate,
    int? endDate,
    String? url,
  }) async {
    List<Map<String, Object?>> requestRows = await database.query(
      HttpRequestModel.tableName,
      where: "created_at >=  datetime(? / 1000, 'unixepoch')"
          "and created_at <= datetime(? / 1000, 'unixepoch')",
      whereArgs: [
        startDate,
        endDate,
      ],
    );
    var requestModels = List<HttpRequestModel>.from(
      requestRows.map(
        (row) => HttpRequestModel.fromJson(row),
      ),
    );
    var requestIds =
        requestModels.map((requestModel) => requestModel.id).toList();

    List<Map<String, Object?>> responseRows = await database.query(
      HttpResponseModel.tableName,
      where: 'request_hash_code IN (?)',
      whereArgs: requestIds,
    );
    var responseModels = List<HttpResponseModel>.from(
      responseRows.map(
        (row) => HttpResponseModel.fromJson(row),
      ),
    );

    var activities = List<HttpActivityModel>.from(
      requestModels.map(
        (requestModel) => HttpActivityModel(
          request: requestModel,
          response: responseModels.singleWhere(
            (responseModel) => responseModel.hashCode == requestModel.hashCode,
          ),
        ),
      ),
    ).toList();
    return activities;
  }
}
