import 'dart:convert';

import '../../domain/entities/http_activity.dart';
import 'byte_util.dart';
import 'date_time_util.dart';

class JsonUtil {
  final _byteUtil = ByteUtil();
  final _dateTimeUtil = DateTimeUtil();

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

  Map<String, String>? compileHeader(
    Map<String, String>? globalHeaders,
    Map<String, String>? headers,
  ) {
    if (globalHeaders != null) {
      if (headers != null) {
        for (var key in headers.keys) {
          globalHeaders[key] = headers[key]!;
        }
        return globalHeaders;
      } else {
        return globalHeaders;
      }
    } else {
      return headers;
    }
  }

  String? encodeRawJson(dynamic rawJson) {
    if (rawJson is Map<String, dynamic>) {
      return (rawJson.isNotEmpty) ? json.encode(rawJson) : null;
    } else if (rawJson is String) {
      return rawJson.isNotEmpty ? rawJson : null;
    } else {
      return null;
    }
  }

  Future<String?> buildActivityJson(
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
