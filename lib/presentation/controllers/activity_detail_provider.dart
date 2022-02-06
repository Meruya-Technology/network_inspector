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

  final pageViewController = PageController(
    initialPage: 0,
  );

  var _currentPage = 0;

  int get currentPage => _currentPage;

  void changeCurrentPage(int index) {
    _currentPage = index;
  }

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
