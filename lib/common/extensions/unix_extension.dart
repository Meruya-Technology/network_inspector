import 'package:intl/intl.dart';

extension UnixExtension on int? {
  String? get convertToYmdHms {
    if (this != null) {
      final dateFormat = DateFormat('y-MM-dd hh:mm:ss');
      final dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return dateFormat.format(dateTime);
    }
    return null;
  }
}
