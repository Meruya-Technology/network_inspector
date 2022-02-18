import 'package:flutter/material.dart';

import 'network_inspector_enum.dart';

class NetworkInspectorValue {
  static String get defaultEmptyString => 'N/A';

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

  static Map<HttpActivityActionType, String> get actionSuccessMessage => {
        HttpActivityActionType.copy: 'Json copied successfully',
        HttpActivityActionType.share: 'Json shared successfully',
      };

  static Map<HttpActivityActionType, String> get actionFailedMessage => {
        HttpActivityActionType.copy: 'Failed to copy json',
        HttpActivityActionType.share: 'Failed to share json',
      };
}
