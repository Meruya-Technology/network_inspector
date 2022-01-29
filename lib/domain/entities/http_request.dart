class HttpRequest {
  final int? id;
  final int? createdAt;
  final String? url;
  final String? method;
  final String? requestHeader;
  final String? requestBody;
  final int? requestSize;
  final int? requestHashCode;

  HttpRequest({
    this.id,
    this.createdAt,
    this.url,
    this.method,
    this.requestHeader,
    this.requestBody,
    this.requestSize,
    this.requestHashCode,
  });
}
