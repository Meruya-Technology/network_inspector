/// @nodoc
class HttpRequest {
  final int? id;
  final int? createdAt;
  final String? baseUrl;
  final String? path;
  final String? params;
  final String? method;
  final String? requestHeader;
  final String? requestBody;
  final int? requestSize;
  final int? requestHashCode;
  final String? cUrl;

  HttpRequest({
    this.id,
    this.createdAt,
    this.baseUrl,
    this.path,
    this.params,
    this.method,
    this.requestHeader,
    this.requestBody,
    this.requestSize,
    this.requestHashCode,
    this.cUrl,
  });
}
