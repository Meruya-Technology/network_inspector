import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/database_helper.dart';

class ActivityProvider extends ChangeNotifier {
  ActivityProvider({
    required BuildContext context,
  });

  Future<void> initialize() async {
    DatabaseHelper.initialize();
  }
}
