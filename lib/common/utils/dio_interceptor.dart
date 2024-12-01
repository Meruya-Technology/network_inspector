import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../domain/entities/http_request.dart';
import '../../domain/entities/http_response.dart';
import '../../network_inspector.dart';
import 'byte_util.dart';
import 'json_util.dart';

class DioInterceptor extends Interceptor {
  /// Enable/Disable overall logging
  final bool logIsAllowed;

  /// Enable/Disable only console logging
  final bool isConsoleLogAllowed;
  final NetworkInspector? networkInspector;
  final Function(
    int requestHashCode,
    String title,
    String message,
  )? onHttpFinish;

  DioInterceptor({
    this.logIsAllowed = true,
    this.isConsoleLogAllowed = true,
    this.networkInspector,
    this.onHttpFinish,
  });

  final _jsonUtil = JsonUtil();
  final _byteUtil = ByteUtil();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (logIsAllowed) {
      await saveRequest(options);
    }
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (logIsAllowed) {
      await saveResponse(response, response.requestOptions);
      await finishActivity(
        response,
        response.requestOptions.uri.toString(),
        response.data.toString(),
        response.requestOptions,
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final logError = '\n[Error Message]: ${err.message}';
    if (logIsAllowed) {
      if (isConsoleLogAllowed) {
        developer.log(logError);
      }
      await saveResponse(err.response, err.requestOptions);
      await finishActivity(
        err.response,
        (err.response?.requestOptions ?? err.requestOptions).uri.toString(),
        (err.response?.data ?? '{}').toString(),
        err.requestOptions,
      );
    }

    if (logIsAllowed && isConsoleLogAllowed) {
      final errorResponse = '\n[Error Response]'
          '\nHeaders : ${err.response?.headers.toString()}'
          '\nParams: ${err.response?.requestOptions.queryParameters.toString()}'
          '\nData : ${_jsonUtil.encodeRawJson(err.response?.data)}'
          '\nStacktrace: ${err.stackTrace.toString()}';

      developer.log(errorResponse);
    }
    return super.onError(err, handler);
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

  Future<void> saveRequest(RequestOptions options) async {
    var payload = HttpRequest(
      baseUrl: options.baseUrl,
      path: options.uri.path,
      params: _jsonUtil.encodeRawJson(options.queryParameters),
      method: options.method,
      requestHeader: _jsonUtil.encodeRawJson(options.headers),
      requestBody: _jsonUtil.encodeRawJson(options.data),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requestSize: _byteUtil.stringToBytes(options.data.toString()),
      requestHashCode: options.hashCode,
    );
    await networkInspector!.writeHttpRequestLog(payload);
  }

  Future<void> saveResponse(
      Response? response, RequestOptions requestOptions) async {
    if (response != null) {
      final RequestOptions request = response.requestOptions;
      final HttpResponse payload = HttpResponse(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        responseHeader: _jsonUtil.encodeRawJson(response.headers.map),
        responseBody: _jsonUtil.encodeRawJson(response.data),
        responseStatusCode: response.statusCode,
        responseStatusMessage: response.statusMessage,
        responseSize: _byteUtil.stringToBytes(response.data.toString()),
        requestHashCode: request.hashCode,
      );
      await networkInspector!.writeHttpResponseLog(payload);
    } else {
      final HttpResponse payload = HttpResponse(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        responseHeader: "No Internet or Null from server",
        responseBody: "Failed",
        responseStatusCode: 000,
        responseStatusMessage: ": No Internet or 'null' from server",
        responseSize: 0,
        requestHashCode: requestOptions.hashCode,
      );
      await networkInspector!.writeHttpResponseLog(payload);
    }
  }

  Future<void> finishActivity(
    Response? response,
    String title,
    String message,
    RequestOptions requestOptions,
  ) async {
    final request = response?.requestOptions ?? requestOptions;
    if (onHttpFinish is Function) {
      await onHttpFinish!(request.hashCode, title, message);
    }
    if (isConsoleLogAllowed) {
      await logRequest(request);
      if (response != null) {
        await logResponse(response);
      }
    }
  }
}
