import '../entities/http_activity.dart';

import '../entities/http_request.dart';
import '../entities/http_response.dart';

abstract class LogRepository {
  Future<List<HttpActivity>?> httpActivities({
    int? startDate,
    int? endDate,
    List<int?>? statusCodes,
    String? url,
  });

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

  Future<bool> deleteHttpActivities();
}
