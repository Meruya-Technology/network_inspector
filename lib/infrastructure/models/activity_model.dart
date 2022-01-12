import 'dart:convert';

import 'package:flutter/services.dart';

class ActivityModel {
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

  ActivityModel({
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

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'],
        url: json['url'],
        method: json['method'],
        requestHeader: json['request_header'],
        requestBody: json['request_body'],
        responseHeader: json['response_header'],
        responseBody: json['response_body'],
        responseStatusCode: json['response_status_code'],
        responseStatusMessage: json['response_status_message'],
        responseTime: json['response_time'],
        responseSize: json['response_size'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['url'] = url;
    json['method'] = method;
    json['request_header'] = requestHeader;
    json['request_body'] = requestBody;
    json['response_header'] = responseHeader;
    json['response_body'] = responseBody;
    json['response_status_code'] = responseStatusCode;
    json['response_status_message'] = responseStatusMessage;
    json['response_time'] = responseTime;
    json['response_size'] = responseSize;
    json['created_at'] = createdAt;
    return json;
  }

  static String tableName = 'activities';

  static Future<Map<String, dynamic>> get migration async {
    final stringJson = await rootBundle.loadString(
      'packages/network_inspector/assets/json/migration_template.json',
    );
    final migrateScript = json.decode(stringJson);
    return migrateScript;
  }
}
