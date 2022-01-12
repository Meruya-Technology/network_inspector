class Activity {
  final int? id;
  final String? url;
  final String? method;
  final String? requestHeader;
  final String? requestBody;
  final String? responseHeader;
  final String? responseBody;
  final int? responseStatusCode;
  final String? responseStatusMessage;
  final String? responseTime;
  final String? responseSize;
  final int? createdAt;

  Activity({
    this.id,
    this.url,
    this.method,
    this.requestHeader,
    this.requestBody,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseStatusMessage,
    this.responseTime,
    this.responseSize,
    this.createdAt,
  });
}
