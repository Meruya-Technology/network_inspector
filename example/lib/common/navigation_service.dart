import 'package:example/presentation/pages/dio_page.dart';
import 'package:example/presentation/pages/http_page.dart';
import 'package:example/presentation/pages/main_page.dart';
import 'package:example/presentation/pages/vanilla_page.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static var navigatorKey = GlobalKey<NavigatorState>();

  static Map<String, Widget Function(BuildContext context)> get routes {
    return {
      MainPage.routeName: (context) => const MainPage(),
      DioPage.routeName: (context) => const DioPage(),
      HttpPage.routeName: (context) => const HttpPage(),
      VanillaPage.routeName: (context) => const VanillaPage(),
    };
  }
}
