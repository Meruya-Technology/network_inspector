import '../entities/http_request.dart';
import '../entities/http_response.dart';

abstract class LogRepository {
  Future<List<HttpRequest>?> httpRequests({
    int? requestHashCode,
  });

  Future<List<HttpResponse>?> httpResponses({
    int? requestHashCode,
  });

  Future<bool> logHttpRequest({
    required HttpRequest httpRequestModel,
  });

  Future<bool> logHttpResponse({
    required HttpResponse httpResponseModel,
  });
}
