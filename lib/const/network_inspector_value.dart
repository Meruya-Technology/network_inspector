import 'package:flutter/material.dart';

class NetworkInspectorValue {
  static Color containerColor(int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return Colors.blue;
    } else if (statusCode >= 200 && statusCode < 300) {
      return Colors.green;
    } else if (statusCode >= 300 && statusCode < 400) {
      return Colors.yellow;
    } else if (statusCode >= 300 && statusCode < 400) {
      return Colors.orange;
    } else if (statusCode >= 500) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
}
