class HttpRequestModel {
  final int? id;
  final int? createdAt;
  final String? url;
  final String? method;
  final String? requestHeader;
  final String? requestBody;
  final int? requestSize;
  final int? requestHashCode;

  HttpRequestModel({
    this.id,
    this.createdAt,
    this.url,
    this.method,
    this.requestHeader,
    this.requestBody,
    this.requestSize,
    this.requestHashCode,
  });

  static String tableName = 'http_requests';

  factory HttpRequestModel.fromJson(Map<String, dynamic> json) =>
      HttpRequestModel(
        id: json['id'],
        createdAt: json['createdAt'],
        url: json['url'],
        method: json['method'],
        requestHeader: json['requestHeader'],
        requestBody: json['requestBody'],
        requestSize: json['requestSize'],
        requestHashCode: json['requestHashCode'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdAt'] = createdAt;
    json['url'] = url;
    json['method'] = method;
    json['requestHeader'] = requestHeader;
    json['requestBody'] = requestBody;
    json['requestSize'] = requestSize;
    json['requestHashCode'] = requestHashCode;
    return json;
  }
}
