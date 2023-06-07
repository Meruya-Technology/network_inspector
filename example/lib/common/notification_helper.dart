import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:network_inspector/network_inspector.dart';

import 'navigation_service.dart';

class NotificationHelper {
  static final localNotification = FlutterLocalNotificationsPlugin();

  static AndroidInitializationSettings? get androidInitSetting {
    return const AndroidInitializationSettings('meruya_logo');
  }

  static DarwinInitializationSettings? get iosInitSetting {
    return const DarwinInitializationSettings();
  }

  static DarwinInitializationSettings? get macOsInitSetting {
    return const DarwinInitializationSettings();
  }

  static InitializationSettings get initializationSettings {
    return InitializationSettings(
      android: androidInitSetting,
      iOS: iosInitSetting,
      macOS: macOsInitSetting,
    );
  }

  static Future<void> initialize({
    Function(NotificationResponse?)? callback,
  }) async {
    await localNotification.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: callback ?? selectNotification,
    );
  }

  static Future<void> selectNotification(NotificationResponse? response) async {
    final payload = response?.payload;
    if (payload != null) {
      debugPrint('notification payload: $response');
    }
    var context = NavigationService.navigatorKey.currentContext;
    if (context != null) {
      if (payload == 'networkInspector') {
        await Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => ActivityPage(),
          ),
        );
      }
    }
  }

  Future<void> showNotification({
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
      styleInformation: BigTextStyleInformation(''),
      fullScreenIntent: true,
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
