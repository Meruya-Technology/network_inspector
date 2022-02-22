import 'package:intl/intl.dart';

extension UnixExtension on int? {
  String? get convertToYmdHms {
    if (this != null) {
      var dateFormat = DateFormat('y-MM-DD hh:mm:ss');
      var dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return dateFormat.format(dateTime);
    }
    return null;
  }
}
