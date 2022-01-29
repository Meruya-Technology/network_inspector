class HttpResponseModel {
  final int? id;
  final int? createdAt;
  final String? responseHeader;
  final String? responseBody;
  final int? responseStatusCode;
  final String? responseStatusMessage;
  final int? responseSize;
  final String? errorLog;
  final int? requestHashCode;

  HttpResponseModel({
    this.id,
    this.createdAt,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseStatusMessage,
    this.responseSize,
    this.errorLog,
    this.requestHashCode,
  });

  static String tableName = 'http_responses';

  factory HttpResponseModel.fromJson(Map<String, dynamic> json) =>
      HttpResponseModel(
        id: json['id'],
        createdAt: json['createdAt'],
        responseHeader: json['responseHeader'],
        responseBody: json['responseBody'],
        responseStatusCode: json['responseStatusCode'],
        responseStatusMessage: json['responseStatusMessage'],
        responseSize: json['responseSize'],
        errorLog: json['errorLog'],
        requestHashCode: json['requestHashCode'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['createdAt'] = createdAt;
    json['responseHeader'] = responseHeader;
    json['responseBody'] = responseBody;
    json['responseStatusCode'] = responseStatusCode;
    json['responseStatusMessage'] = responseStatusMessage;
    json['responseSize'] = responseSize;
    json['errorLog'] = errorLog;
    json['requestHashCode'] = requestHashCode;
    return json;
  }
}
