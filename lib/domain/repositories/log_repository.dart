import 'package:network_inspector/domain/entities/http_request.dart';
import 'package:network_inspector/domain/entities/http_response.dart';

abstract class LogRepository {
  Future<List<HttpRequest>?> httpRequests({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
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
