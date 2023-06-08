import '../models/http_activity_model.dart';
import '../models/http_request_model.dart';
import '../models/http_response_model.dart';

abstract class LogDatasource {
  Future<List<HttpActivityModel>?> httpActivities({
    int? startDate,
    int? endDate,
    List<int?>? statusCodes,
    String? url,
  });

  Future<List<HttpRequestModel>?> httpRequests({
    int? requestHashCode,
  });

  Future<List<HttpResponseModel>?> httpResponses({
    int? requestHashCode,
  });

  Future<bool> logHttpRequest({
    required HttpRequestModel httpRequestModel,
  });

  Future<bool> logHttpResponse({
    required HttpResponseModel httpResponseModel,
  });

  Future<bool> deleteHttpActivities();
}
