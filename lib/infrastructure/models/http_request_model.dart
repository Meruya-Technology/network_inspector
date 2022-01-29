import 'dart:convert';

import 'package:flutter/services.dart';

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
        createdAt: json['created_at'],
        url: json['url'],
        method: json['method'],
        requestHeader: json['request_header'],
        requestBody: json['request_body'],
        requestSize: json['request_size'],
        requestHashCode: json['request_hash_code'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['created_at'] = createdAt;
    json['url'] = url;
    json['method'] = method;
    json['request_header'] = requestHeader;
    json['request_body'] = requestBody;
    json['request_size'] = requestSize;
    json['request_hash_code'] = requestHashCode;
    return json;
  }

  static Future<Map<String, dynamic>> get migration async {
    final stringJson = await rootBundle.loadString(
      'packages/network_inspector/assets/json/http_request.json',
    );
    final migrateScript = json.decode(stringJson);
    return migrateScript;
  }
}
