class Request {
  final int? id;
  final int? createdAt;
  final String? url;
  final String? method;
  final String? responseHeader;
  final String? responseBody;
  final int? responseSize;
  final int? responseStatusCode;
  final int? responseStatusMessage;
  final String? errorLog;
  final int? requestHashCode;

  Request({
    this.id,
    this.createdAt,
    this.url,
    this.method,
    this.responseHeader,
    this.responseBody,
    this.responseSize,
    this.responseStatusCode,
    this.responseStatusMessage,
    this.errorLog,
    this.requestHashCode,
  });
}
