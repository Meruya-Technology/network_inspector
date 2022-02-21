import 'package:intl/intl.dart';

extension IntToByteExtension on int? {
  static const int bytePerLevel = 1024;
  static const String kiloByteSymbol = 'kb';
  static NumberFormat doubleFormat = NumberFormat("###.##");

  String byteToKiloByte(bool useSymbol) {
    final value = this ?? 0;
    var result = (value / bytePerLevel);
    return '${doubleFormat.format(result)} $kiloByteSymbol';
  }
}
