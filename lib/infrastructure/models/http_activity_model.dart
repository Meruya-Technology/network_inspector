import 'package:network_inspector/infrastructure/models/http_request_model.dart';
import 'package:network_inspector/infrastructure/models/http_response_model.dart';

class HttpActivityModel {
  final HttpRequestModel? request;
  final HttpResponseModel? response;

  HttpActivityModel({
    this.request,
    this.response,
  });
}
