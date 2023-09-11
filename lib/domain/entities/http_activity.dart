import 'http_request.dart';
import 'http_response.dart';

/// @nodoc
class HttpActivity {
  final HttpRequest? request;
  final HttpResponse? response;

  HttpActivity({
    this.request,
    this.response,
  });
}
