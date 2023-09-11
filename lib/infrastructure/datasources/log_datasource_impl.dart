import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';

import '../models/http_activity_model.dart';
import '../models/http_request_model.dart';
import '../models/http_response_model.dart';
import 'log_datasource.dart';

/// @nodoc
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
    List<int?>? statusCodes,
    String? url,
  }) async {
    final filteredByDate = (startDate != null && endDate != null);
    final hasFilter = filteredByDate && (url != null);
    String query = '';
    final queryArgs = [];
    if (filteredByDate) {
      queryArgs.addAll([startDate, endDate]);
      query += "created_at >=  datetime(? / 1000, 'unixepoch')"
          "and created_at <= datetime(? / 1000, 'unixepoch')";
    }
    if (url != null) {
      queryArgs.add(url);
      if (filteredByDate) {
        query += "and ";
      }
      query += "url = ?";
    }

    List<Map<String, Object?>> requestRows = await database.query(
      HttpRequestModel.tableName,
      where: hasFilter ? query : null,
      whereArgs: queryArgs,
      orderBy: 'created_at DESC',
    );
    final requestModels = List<HttpRequestModel>.from(
      requestRows.map(
        (row) => HttpRequestModel.fromJson(row),
      ),
    );
    final requestIds = requestModels
        .map((requestModel) => requestModel.requestHashCode)
        .toList();

    String responseQuery = 'request_hash_code in (${requestIds.join(', ')})';
    if (statusCodes != null && statusCodes.isNotEmpty) {
      responseQuery = '$responseQuery and '
          'response_status_code in (${statusCodes.join(', ')})';
    }

    List<Map<String, Object?>> responseRows = await database.query(
      HttpResponseModel.tableName,
      where: responseQuery,
    );
    final responseModels = List<HttpResponseModel>.from(
      responseRows.map(
        (row) => HttpResponseModel.fromJson(row),
      ),
    );

    final activities = (responseModels.isNotEmpty)
        ? List<HttpActivityModel>.from(
            requestModels
                .map(
                  (requestModel) => HttpActivityModel(
                    request: requestModel,
                    response: responseModels.singleWhereOrNull(
                      (responseModel) => (responseModel.requestHashCode ==
                          requestModel.requestHashCode),
                    ),
                  ),
                )
                .where((element) => element.response != null),
          ).toList()
        : null;
    return activities;
  }

  @override
  Future<bool> deleteHttpActivities() async {
    var id = await database.delete(
      HttpRequestModel.tableName,
    );
    return (id != 0);
  }
}
