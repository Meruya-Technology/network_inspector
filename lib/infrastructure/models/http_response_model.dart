import 'dart:convert';

import 'package:flutter/services.dart';

/// @nodoc
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
        createdAt: json['created_at'],
        responseHeader: json['response_header'],
        responseBody: json['response_body'],
        responseStatusCode: json['response_status_code'],
        responseStatusMessage: json['response_status_message'],
        responseSize: json['response_size'],
        errorLog: json['error_log'],
        requestHashCode: json['request_hash_code'],
      );

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

  static Future<Map<String, dynamic>> get migration async {
    final stringJson = await rootBundle.loadString(
      'packages/network_inspector/assets/json/http_response.json',
    );
    final migrateScript = json.decode(stringJson);
    return migrateScript;
  }
}
