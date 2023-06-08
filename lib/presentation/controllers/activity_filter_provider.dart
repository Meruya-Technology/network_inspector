import 'package:flutter/material.dart';

class ActivityFilterProvider extends ChangeNotifier {
  List<int?> selectedStatusCodes = [];

  void onChangeSelectedStatusCode(int statusCode) {
    if (selectedStatusCodes.contains(statusCode)) {
      selectedStatusCodes.remove(statusCode);
    } else {
      selectedStatusCodes.add(statusCode);
    }
    notifyListeners();
  }
}