import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/database_helper.dart';

class ActivityProvider extends ChangeNotifier {
  final BuildContext context;
  ActivityProvider({
    required this.context,
  });

  Future<void> initialize() async {
    DatabaseHelper.initialize();
  }
}
