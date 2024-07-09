import 'dart:convert';

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
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    json['base_url'] = baseUrl;
    json['path'] = path;
    json['params'] = params;
    json['method'] = method;
    if (requestHeader != null) {
      if (jsonEncode(requestHeader).isNotEmpty) {
        json['request_header'] = requestHeader;
      }
    }
    if (requestBody != null) {
      json['request_body'] = requestBody;
    }
    json['request_size'] = requestSize;
    json['request_hash_code'] = requestHashCode;
    return json;
  }
}
