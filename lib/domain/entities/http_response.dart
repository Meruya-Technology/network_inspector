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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    json['response_header'] = responseHeader;
    json['response_body'] = responseBody;
    json['response_status_code'] = responseStatusCode;
    json['response_status_message'] = responseStatusMessage;
    json['response_size'] = responseSize;
    json['error_log'] = errorLog;
    json['request_hash_code'] = requestHashCode;
    return json;
  }
}
