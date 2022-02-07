import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/http_activity.dart';
import 'byte_util.dart';
import 'date_time_util.dart';
import 'dart:developer' as developer;

class JsonUtil {
  final _byteUtil = ByteUtil();
  final _dateTimeUtil = DateTimeUtil();

  String? encodeRawJson(dynamic rawJson) {
    if (rawJson is Map<String, dynamic>) {
      return (rawJson.isNotEmpty) ? json.encode(rawJson) : null;
    } else if (rawJson is String) {
      return rawJson;
    } else {
      return null;
    }
  }

  static Map<String, dynamic>? tryDecodeRawJson(String? rawJson) {
    try {
      final decoded = json.decode(rawJson!);
      return decoded;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> tryEncodeJson(Map<String, dynamic> map) {
    try {
      var encoded = json.encode(map);
      return Future.value(encoded);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> buildJsonString(
    HttpActivity httpActivity,
  ) async {
    final request = httpActivity.request;
    final response = httpActivity.response;
    var jsonOutput = {
      'base_url': request?.baseUrl,
      'path': request?.path,
      'total_transfer_size': _byteUtil.totalTransferSize(
        request?.requestSize,
        response?.responseSize,
        true,
      ),
      'total_transfer_time': _dateTimeUtil.milliSecondDifference(
        request?.createdAt,
        response?.createdAt,
      ),
      'request_data': {
        'query_params': tryDecodeRawJson(request?.params),
        'request_headers': tryDecodeRawJson(request?.requestHeader),
        'request_body': tryDecodeRawJson(request?.requestBody),
        'request_size': request?.requestSize,
        'created_at': request?.createdAt
      },
      'response_data': {
        'response_headers': tryDecodeRawJson(response?.responseHeader),
        'response_body': tryDecodeRawJson(response?.responseBody),
        'response_status_code': response?.responseStatusCode,
        'response_status_message': response?.responseStatusMessage,
        'response_size': '${response?.responseSize ?? 0} kb',
        'created_at': response?.createdAt,
      },
    };
    return tryEncodeJson(jsonOutput);
  }
}
