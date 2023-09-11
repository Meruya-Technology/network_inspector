import '../../domain/entities/http_activity.dart';
import '../../domain/entities/http_request.dart';
import '../../domain/entities/http_response.dart';
import '../../domain/repositories/log_repository.dart';
import '../datasources/log_datasource.dart';
import '../mappers/http_activity_mapper.dart';
import '../mappers/http_request_mapper.dart';
import '../mappers/http_response_mapper.dart';

/// @nodoc
class LogRepositoryImpl implements LogRepository {
  final LogDatasource logDatasource;

  LogRepositoryImpl({
    required this.logDatasource,
  });

  @override
  Future<List<HttpActivity>?> httpActivities({
    int? startDate,
    int? endDate,
    List<int?>? statusCodes,
    String? url,
  }) async {
    var models = await logDatasource.httpActivities(
      url: url,
      startDate: startDate,
      statusCodes: statusCodes,
      endDate: endDate,
    );
    var entities = (models != null)
        ? List<HttpActivity>.from(
            models.map(
              (model) => HttpActivityMapper.toEntity(
                model,
              ),
            ),
          )
        : null;
    return entities;
  }

  @override
  Future<List<HttpRequest>?> httpRequests({
    int? requestHashCode,
  }) async {
    var models = await logDatasource.httpRequests(
      requestHashCode: requestHashCode,
    );
    var entities = (models != null)
        ? List<HttpRequest>.from(
            models.map(
              (model) => HttpRequestMapper.toEntity(
                model,
              ),
            ),
          )
        : null;
    return entities;
  }

  @override
  Future<List<HttpResponse>?> httpResponses({
    int? requestHashCode,
  }) async {
    var models = await logDatasource.httpResponses(
      requestHashCode: requestHashCode,
    );
    var entities = (models != null)
        ? List<HttpResponse>.from(
            models.map(
              (model) => HttpResponseMapper.toEntity(
                model,
              ),
            ),
          )
        : null;
    return entities;
  }

  @override
  Future<bool> logHttpRequest({
    required HttpRequest httpRequestModel,
  }) async {
    var model = HttpRequestMapper.toModel(httpRequestModel);
    var result = await logDatasource.logHttpRequest(
      httpRequestModel: model,
    );
    return result;
  }

  @override
  Future<bool> logHttpResponse({
    required HttpResponse httpResponseModel,
  }) async {
    var model = HttpResponseMapper.toModel(httpResponseModel);
    var result = await logDatasource.logHttpResponse(
      httpResponseModel: model,
    );
    return result;
  }

  @override
  Future<bool> deleteHttpActivities() async {
    var result = logDatasource.deleteHttpActivities();
    return result;
  }
}
