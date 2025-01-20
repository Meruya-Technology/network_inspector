import '../../domain/entities/http_request.dart';
import '../models/http_request_model.dart';

/// @nodoc
class HttpRequestMapper {
  static HttpRequest toEntity(HttpRequestModel model) {
    return HttpRequest(
      id: model.id,
      createdAt: model.createdAt,
      baseUrl: model.baseUrl,
      path: model.path,
      params: model.params,
      method: model.method,
      requestHeader: model.requestHeader,
      requestBody: model.requestBody,
      requestSize: model.requestSize,
      requestHashCode: model.requestHashCode,
      cUrl: model.cUrl,
    );
  }

  static HttpRequestModel toModel(HttpRequest entity) {
    return HttpRequestModel(
      id: entity.id,
      createdAt: entity.createdAt,
      baseUrl: entity.baseUrl,
      path: entity.path,
      params: entity.params,
      method: entity.method,
      requestHeader: entity.requestHeader,
      requestBody: entity.requestBody,
      requestSize: entity.requestSize,
      requestHashCode: entity.requestHashCode,
      cUrl: entity.cUrl,
    );
  }
}
