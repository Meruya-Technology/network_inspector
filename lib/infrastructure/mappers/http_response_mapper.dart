import '../../domain/entities/http_response.dart';
import '../models/http_response_model.dart';

/// @nodoc
class HttpResponseMapper {
  static HttpResponse toEntity(HttpResponseModel model) {
    return HttpResponse(
      id: model.id,
      createdAt: model.createdAt,
      responseHeader: model.responseHeader,
      responseBody: model.responseBody,
      responseSize: model.responseSize,
      responseStatusCode: model.responseStatusCode,
      responseStatusMessage: model.responseStatusMessage,
      errorLog: model.errorLog,
      requestHashCode: model.requestHashCode,
    );
  }

  static HttpResponseModel toModel(HttpResponse entity) {
    return HttpResponseModel(
      id: entity.id,
      createdAt: entity.createdAt,
      responseHeader: entity.responseHeader,
      responseBody: entity.responseBody,
      responseSize: entity.responseSize,
      responseStatusCode: entity.responseStatusCode,
      responseStatusMessage: entity.responseStatusMessage,
      errorLog: entity.errorLog,
      requestHashCode: entity.requestHashCode,
    );
  }
}
