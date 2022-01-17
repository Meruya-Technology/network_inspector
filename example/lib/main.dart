import 'package:example/common/notification_helper.dart';
import 'package:example/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:provider/provider.dart';

import 'common/navigation_service.dart';
import 'presentation/controllers/main_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NetworkInspector.initialize();
  NotificationHelper.initialize();
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(
        context: context,
      ),
      builder: (context, child) => MaterialApp(
        title: 'Network inspector',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: MainPage.routeName,
        routes: NavigationService.routes,
      ),
    );
  }
}
