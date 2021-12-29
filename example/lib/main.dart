import 'package:example/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:network_inspector/network_inspector.dart';
import 'package:provider/provider.dart';

import 'presentation/controllers/main_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  NetworkInspector.initialize();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (BuildContext context) => MainPage(),
        },
      ),
    );
  }
}
