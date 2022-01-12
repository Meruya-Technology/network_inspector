import 'package:example/common/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_inspector/network_inspector_presentation.dart';

class NotificationHelper {
  static final localNotification = FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings? get androidInitSetting {
    return AndroidInitializationSettings('ic_launcher');
  }

  static IOSInitializationSettings? get iosInitSetting {
    return IOSInitializationSettings();
  }

  static MacOSInitializationSettings? get macOsInitSetting {
    return MacOSInitializationSettings();
  }

  static InitializationSettings get initializationSettings {
    return InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
      macOS: macOsInitSetting,
    );
  }

  static Future<void> initialize({
    Function(String?)? callback,
  }) async {
    await localNotification.initialize(
      initializationSettings,
      onSelectNotification: callback ?? selectNotification,
    );
  }

  static Future<void> selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    var context = NavigationService.navigatorKey.currentContext;
    if (context != null) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => ActivityPage(),
        ),
      );
    }
  }
}
