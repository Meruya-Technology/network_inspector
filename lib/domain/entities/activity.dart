class Activity {
  final int id;
  final String? url;
  final String? requestHeader;
  final String? requestBody;
  final String? responseHeader;
  final String? responseBody;
  final String? responseStatusCode;
  final String? responseTime;
  final String? responseSize;
  final int? createdAt;

  Activity({
    required this.id,
    this.url,
    this.requestHeader,
    this.requestBody,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseTime,
    this.responseSize,
    this.createdAt,
  });
}
