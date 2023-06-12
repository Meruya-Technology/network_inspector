import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_inspector/common/utils/dio_interceptor.dart';
import 'package:network_inspector/common/utils/http_interceptor.dart';
import 'package:network_inspector/network_inspector.dart';

import '../../common/notification_helper.dart';

class MainProvider extends ChangeNotifier {
  final BuildContext context;

  MainProvider({
    required this.context,
  }) {
    injectDependencies();
  }

  NotificationHelper? notificationHelper;
  NetworkInspector? networkInspector;

  Future<void> injectDependencies() async {
    notificationHelper = NotificationHelper();
    networkInspector = NetworkInspector();
  }

  Dio get dioClient {
    return Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.2:8000/',
        connectTimeout: const Duration(seconds: 10),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer i109gh23j9u1h3811io2n391'
        },
      ),
    )..interceptors.add(
        DioInterceptor(
          logIsAllowed: true,
          networkInspector: networkInspector,
          onHttpFinish: (hashCode, title, message) {
            notifyActivity(
              title: title,
              message: message,
            );
          },
        ),
      );
  }

  HttpInterceptor get httpClient {
    final client = Client();

    final interceptor = HttpInterceptor(
      logIsAllowed: true,
      client: client,
      baseUrl: Uri.parse('http://192.168.1.7:8000/'),
      networkInspector: networkInspector,
      onHttpFinish: (hashCode, title, message) {
        notifyActivity(
          title: title,
          message: message,
        );
      },
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer WEKLSSS'
      },
    );
    return interceptor;
  }

  Future<void> notifyActivity({
    required String title,
    required String message,
  }) async {
    await notificationHelper?.showNotification(
      classHashId: notificationHelper.hashCode,
      title: title,
      message: message,
      payload: 'networkInspector',
    );
  }
}
