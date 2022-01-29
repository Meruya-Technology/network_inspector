import 'package:network_inspector/infrastructure/models/http_request_model.dart';
import 'package:network_inspector/infrastructure/models/http_response_model.dart';

abstract class LogDatasource {
  Future<List<HttpRequestModel>?> httpRequests({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
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
}
