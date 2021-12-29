import 'dart:convert';

import 'package:flutter/services.dart';

class ActivityModel {
  final int id;
  final String url;
  final String requestHeader;
  final String requestBody;
  final String responseHeader;
  final String responseBody;
  final String responseStatusCode;
  final String responseTime;
  final String responseSize;

  ActivityModel({
    required this.id,
    required this.url,
    required this.requestHeader,
    required this.requestBody,
    required this.responseHeader,
    required this.responseBody,
    required this.responseStatusCode,
    required this.responseTime,
    required this.responseSize,
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
    return json;
  }

  static Future<Map<String, dynamic>> get migration async {
    final stringJson = await rootBundle.loadString(
      'packages/network_inspector/assets/json/activity_migration.json',
    );
    final migrateScript = json.decode(stringJson);
    return migrateScript;
  }
}
