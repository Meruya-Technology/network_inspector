import 'dart:convert';

extension JsonExtension on String? {
  String get prettify {
    if (this != null) {
      var decoded = json.decode(this!);
      var encoder = const JsonEncoder.withIndent('   ');
      return encoder.convert(decoded);
    }
    return 'N/A';
  }
}
