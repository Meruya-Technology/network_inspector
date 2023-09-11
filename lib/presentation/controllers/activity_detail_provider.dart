import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../common/utils/json_util.dart';
import '../../const/network_inspector_enum.dart';
import '../../const/network_inspector_value.dart';
import '../../domain/entities/http_activity.dart';

/// @nodoc
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

  Future<void> copyHttpActivity(String content) async {
    var clipBoardData = ClipboardData(text: content);
    Clipboard.setData(clipBoardData).then((value) {
      showSnackBar('Json copied successfully');
    });
  }

  Future<void> shareHttpActivity(String content) async {
    Share.share(
      content,
      subject: 'Http Activity ${httpActivity.request?.path}',
    );
  }

  Future<void> copyActivityData(String content) async {
    var clipBoardData = ClipboardData(text: content);
    Clipboard.setData(clipBoardData).then((value) {
      showSnackBar('Data copied successfully');
    });
  }

  Future<void> shareActivityData(String title, String content) async {
    Share.share(
      content,
      subject: '$title : ${httpActivity.request?.path}',
    );
  }

  Future<void> buildJson(
    Function(String content) action,
    HttpActivityActionType actionType,
  ) async {
    _jsonUtil.buildActivityJson(httpActivity).then((result) {
      if (result != null) {
        action(result);
      } else {
        showSnackBar(
          NetworkInspectorValue.actionFailedMessage[actionType]!,
        );
      }
    }, onError: (e) {
      showSnackBar('${NetworkInspectorValue.actionFailedMessage[actionType]!}'
          '${e.toString()}');
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
