import 'dart:convert';

import 'package:flutter/material.dart';
import '../../domain/entities/http_activity.dart';

class ActivityDetailProvider extends ChangeNotifier {
  final BuildContext context;
  final HttpActivity httpActivity;
  ActivityDetailProvider({
    required this.httpActivity,
    required this.context,
  });

  bool headerIsNotEmpty(dynamic header) {
    var isNotEmpty = false;
    if (header is String) {
      var encodedHeader = jsonDecode(header);
      isNotEmpty = (encodedHeader.isNotEmpty);
    } else {
      isNotEmpty = (header != null);
    }
    return isNotEmpty;
  }
}
