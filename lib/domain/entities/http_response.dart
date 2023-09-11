/// @nodoc
class HttpResponse {
  final int? id;
  final int? createdAt;
  final String? responseHeader;
  final String? responseBody;
  final int? responseStatusCode;
  final String? responseStatusMessage;
  final int? responseSize;
  final String? errorLog;
  final int? requestHashCode;

  HttpResponse({
    this.id,
    this.createdAt,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseStatusMessage,
    this.errorLog,
    this.responseSize,
    this.requestHashCode,
  });
}
