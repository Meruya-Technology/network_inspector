import 'package:example/common/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_inspector/network_inspector_presentation.dart';

class NotificationHelper {
  static final localNotification = FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings? get androidInitSetting {
    return AndroidInitializationSettings('meruya_logo');
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

  static Future<void> showNotification({
    required int classHashId,
    required String title,
    required String message,
    required String payload,
  }) async {
    const androidNotificationDetail = AndroidNotificationDetails(
      'network-inspector-channel',
      'Channel for example',
      channelDescription: 'This channel created for testing network inspector'
          'package',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidNotificationDetail,
    );
    await localNotification.show(
      /// Show id here
      classHashId,

      /// Use title here
      title,

      /// Use body here
      message,

      /// Use specific chanel here
      platformChannelSpecifics,

      /// Use payload here
      payload: payload,
    );
  }
}
