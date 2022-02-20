import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:network_inspector/network_inspector.dart';

import '../../common/dio_interceptor.dart';
import '../../common/http_interceptor.dart';
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
        baseUrl: 'http://192.168.1.4:8000/',
        connectTimeout: 10 * 1000, // 10 second
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer i109gh23j9u1h3811io2n391'
        },
      ),
    )..interceptors.add(
        DioInterceptor(
          logIsAllowed: true,
          notificationHelper: notificationHelper,
          networkInspector: networkInspector,
        ),
      );
  }

  HttpInterceptor get httpClient {
    final client = Client();
    final interceptor = HttpInterceptor(
      client: client,
    );
    return interceptor;
  }
}
