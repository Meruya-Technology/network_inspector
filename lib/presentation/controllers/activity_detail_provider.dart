import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/http_activity.dart';
import '../../network_inspector.dart';

class ActivityDetailProvider extends ChangeNotifier {
  final BuildContext context;
  final HttpActivity httpActivity;
  ActivityDetailProvider({
    required this.httpActivity,
    required this.context,
  });

  final _jsonUtil = JsonUtil();
  final pageViewController = PageController(
    initialPage: 0,
  );

  var _currentPage = 0;

  int get currentPage => _currentPage;

  Future<void> changeCurrentPage(int index) async {
    _currentPage = index;
  }

  Future<void> copyHttpActivity() async {
    _jsonUtil.buildJsonString(httpActivity).then((result) {
      if (result != null) {
        var clipBoardData = ClipboardData(text: result);
        Clipboard.setData(clipBoardData).then((value) {
          showSnackBar('Json copied successfully');
        });
      } else {
        showSnackBar('Failed to copy json');
      }
    }, onError: (e) {
      showSnackBar('Failed to copy json, ${e.toString()}');
    });
  }

  Future<void> showSnackBar(String message) async {
    final snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
