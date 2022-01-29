import '../../domain/entities/http_request.dart';
import '../models/http_request_model.dart';

class HttpRequestMapper {
  static HttpRequest toEntity(HttpRequestModel model) {
    return HttpRequest(
      id: model.id,
      createdAt: model.createdAt,
      url: model.url,
      method: model.method,
      requestHeader: model.requestHeader,
      requestBody: model.requestBody,
      requestSize: model.requestSize,
      requestHashCode: model.requestHashCode,
    );
  }

  static HttpRequestModel toModel(HttpRequest entity) {
    return HttpRequestModel(
      id: entity.id,
      createdAt: entity.createdAt,
      url: entity.url,
      method: entity.method,
      requestHeader: entity.requestHeader,
      requestBody: entity.requestBody,
      requestSize: entity.requestSize,
      requestHashCode: entity.requestHashCode,
    );
  }
}
