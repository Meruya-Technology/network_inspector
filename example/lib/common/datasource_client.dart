import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

class DatasourceClient {
  final Dio? dioClient;
  final Client? httpClient;
  final HttpClient? vanillaClient;
  final DatasourceClientType datasourceClientType;

  DatasourceClient({
    this.dioClient,
    this.httpClient,
    this.vanillaClient,
    required this.datasourceClientType,
  });
}

enum DatasourceClientType {
  dio,
  http,
  vanilla,
}
