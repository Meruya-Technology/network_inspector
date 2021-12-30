import 'dart:convert';

import 'package:flutter/services.dart';

class ActivityModel {
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

  ActivityModel({
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

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json['id'],
        url: json['url'],
        requestHeader: json['request_header'],
        requestBody: json['request_body'],
        responseHeader: json['response_header'],
        responseBody: json['response_body'],
        responseStatusCode: json['response_status_code'],
        responseTime: json['response_time'],
        responseSize: json['response_size'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['url'] = url;
    json['request_header'] = requestHeader;
    json['request_body'] = requestBody;
    json['response_header'] = responseHeader;
    json['response_body'] = responseBody;
    json['response_status_code'] = responseStatusCode;
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
