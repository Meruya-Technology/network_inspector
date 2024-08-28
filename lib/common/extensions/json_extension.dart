import 'dart:convert';

extension JsonExtension on String? {
  String get prettify {
    if (this != null) {
      try {
        var decoded = json.decode(this!);
        var encoder = const JsonEncoder.withIndent('   ');
        return encoder.convert(decoded);
      } catch (e) {
        return this ?? 'N/A-Cannot Parse';
      }
    }
    return 'N/A';
  }
}
