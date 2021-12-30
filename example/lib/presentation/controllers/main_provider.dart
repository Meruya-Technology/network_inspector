import 'package:flutter/material.dart';
import 'package:network_inspector/network_inspector.dart';

class MainProvider extends ChangeNotifier {
  final BuildContext context;
  MainProvider({
    required this.context,
  }) {
    initialize();
  }

  Future<void> initialize() async {
    NetworkInspector.initialize();
  }
}
