import 'dart:convert';

extension JsonUtil on String? {
  String get prettify {
    var decoded = json.decode(this!);
    var encoder = const JsonEncoder.withIndent('   ');
    return encoder.convert(decoded);
  }
}
