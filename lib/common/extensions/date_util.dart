import 'package:intl/intl.dart';

extension IntToDateTime on int? {
  String? get convertToYmdHms {
    if (this != null) {
      var dateFormat = DateFormat('y-MM-DD hh:mm:ss');
      var dateTime = DateTime.fromMillisecondsSinceEpoch(this!);
      return dateFormat.format(dateTime);
    }
    return null;
  }
}
