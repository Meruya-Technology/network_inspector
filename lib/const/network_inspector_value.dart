import 'package:flutter/material.dart';

class NetworkInspectorValue {
  static Map<String?, Color> get containerColor => {
        'GET': Colors.blue,
        'POST': Colors.green,
        'DELETE': Colors.red,
        'PUT': Colors.amber,
        null: Colors.grey,
      };
}
