import 'package:dio/dio.dart';
import 'package:example/common/network_interceptor.dart';
import 'package:example/common/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:network_inspector/network_inspector.dart';

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
        baseUrl: 'http://192.168.1.7:8000/',
        connectTimeout: 10 * 1000, // 10 second
        headers: {
          'content-type': 'application/json',
        },
      ),
    )..interceptors.add(
        NetworkInterceptor(
          logIsAllowed: true,
          notificationHelper: notificationHelper,
          networkInspector: networkInspector,
        ),
      );
  }
}
