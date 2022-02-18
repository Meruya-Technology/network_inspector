import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:network_inspector/domain/entities/http_request.dart';
import 'package:network_inspector/domain/entities/http_response.dart';
import 'package:network_inspector/network_inspector.dart';

import 'notification_helper.dart';

class NetworkInterceptor extends Interceptor {
  final bool logIsAllowed;
  final NotificationHelper? notificationHelper;
  final NetworkInspector? networkInspector;

  NetworkInterceptor({
    this.logIsAllowed = false,
    this.notificationHelper,
    this.networkInspector,
  });

  final _jsonUtil = JsonUtil();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var payload = HttpRequest(
      baseUrl: options.baseUrl,
      path: options.uri.path,
      params: _jsonUtil.encodeRawJson(options.queryParameters),
      method: options.method,
      requestHeader: _jsonUtil.encodeRawJson(options.headers),
      requestBody: _jsonUtil.encodeRawJson(options.data),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requestSize: stringToBytes(options.data.toString()),
      requestHashCode: options.hashCode,
    );
    await networkInspector!.writeHttpRequestLog(payload);
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    var request = response.requestOptions;
    var payload = HttpResponse(
      createdAt: DateTime.now().millisecondsSinceEpoch,
      responseHeader: _jsonUtil.encodeRawJson(response.headers.map),
      responseBody: _jsonUtil.encodeRawJson(response.data),
      responseStatusCode: response.statusCode,
      responseStatusMessage: response.statusMessage,
      responseSize: stringToBytes(response.data.toString()),
      requestHashCode: request.hashCode,
    );
    await networkInspector!.writeHttpResponseLog(payload);
    await finishActivity(
      response,
      request.uri.toString(),
      response.data.toString(),
    );
    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    var logError = '\n[Error Message]: ${err.message}';
    if (logIsAllowed) {
      developer.log(logError);
    }

    var errorResponse = '\n[Error Response]'
        '\nHeaders : ${err.response?.headers.toString()}'
        '\nParams: ${err.response?.requestOptions.queryParameters.toString()}'
        '\nData : ${_jsonUtil.encodeRawJson(err.response?.data)}'
        '\nStacktrace: ${err.stackTrace.toString()}';

    if (logIsAllowed) {
      developer.log(errorResponse);
    }
    handler.next(err);
  }

  Future<void> logRequest(RequestOptions request) async {
    var logTemplate = '\n[Request url] ${request.uri.toString()}'
        '\n[Request header] ${request.headers.toString()}'
        '\n[Request param] ${request.queryParameters}'
        '\n[Request body] ${_jsonUtil.encodeRawJson(request.data)}'
        '\n[Request method] ${request.method}'
        '\n[Request content-type] ${request.contentType}';
    developer.log(logTemplate);
  }

  Future<void> logResponse(Response response) async {
    var logTemplate = '\n[Response header] ${response.headers.toString()}'
        '\n[Response body] ${_jsonUtil.encodeRawJson(response.data)}'
        '\n[Response code] ${response.statusCode}'
        '\n[Response message] ${response.statusMessage}'
        '\n[Response extra] ${response.extra}';
    developer.log(logTemplate);
  }

  Future<void> finishActivity(
    Response response,
    String title,
    String message,
  ) async {
    var request = response.requestOptions;
    notifyResponse(
      title: title,
      message: message,
    );
    if (logIsAllowed) {
      await logRequest(request);
      await logResponse(response);
    }
  }

  Future<void> notifyResponse({
    required String title,
    required String message,
  }) async {
    await NotificationHelper.showNotification(
      classHashId: notificationHelper.hashCode,
      title: title,
      message: message,
      payload: 'networkInspector',
    );
  }

  int stringToBytes(String data) {
    final bytes = utf8.encode(data);
    final size = Uint8List.fromList(bytes);
    return size.lengthInBytes;
  }
}
