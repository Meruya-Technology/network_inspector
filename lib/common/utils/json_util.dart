import 'dart:convert';

class JsonUtil {
  String? proccessRaw(dynamic rawJson) {
    if (rawJson is Map<String, dynamic>) {
      return (rawJson.isNotEmpty) ? json.encode(rawJson) : null;
    } else if (rawJson is String) {
      return tryDecodeRawJson(rawJson);
    } else {
      return null;
    }
  }

  static String? tryDecodeRawJson(String rawJson) {
    try {
      final decoded = json.decode(rawJson);
      final encode = json.encode(decoded);
      return encode;
    } catch (e) {
      return null;
    }
  }
}
