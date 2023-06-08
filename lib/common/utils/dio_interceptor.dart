import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../domain/entities/http_request.dart';
import '../../domain/entities/http_response.dart';
import '../../network_inspector.dart';
import 'byte_util.dart';
import 'json_util.dart';

class DioInterceptor extends Interceptor {
  final bool logIsAllowed;
  final NetworkInspector? networkInspector;
  final Function(
    int requestHashCode,
    String title,
    String message,
  )? onHttpFinish;

  DioInterceptor({
    this.logIsAllowed = true,
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
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    if (logIsAllowed) {
      await saveResponse(response);
      await finishActivity(
        response,
        response.requestOptions.uri.toString(),
        response.data.toString(),
      );
    }
    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    var logError = '\n[Error Message]: ${err.message}';
    if (logIsAllowed) {
      developer.log(logError);
      await saveResponse(err.response!);
      await finishActivity(
        err.response!,
        err.response!.requestOptions.uri.toString(),
        err.response!.data.toString(),
      );
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

  Future<void> saveResponse(Response response) async {
    var request = response.requestOptions;
    var payload = HttpResponse(
      createdAt: DateTime.now().millisecondsSinceEpoch,
      responseHeader: _jsonUtil.encodeRawJson(response.headers.map),
      responseBody: _jsonUtil.encodeRawJson(response.data),
      responseStatusCode: response.statusCode,
      responseStatusMessage: response.statusMessage,
      responseSize: _byteUtil.stringToBytes(response.data.toString()),
      requestHashCode: request.hashCode,
    );
    await networkInspector!.writeHttpResponseLog(payload);
  }

  Future<void> finishActivity(
    Response response,
    String title,
    String message,
  ) async {
    var request = response.requestOptions;
    if (onHttpFinish is Function) {
      await onHttpFinish!(response.requestOptions.hashCode, title, message);
    }
    await logRequest(request);
    await logResponse(response);
  }
}
