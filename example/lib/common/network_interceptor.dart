import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:example/common/notification_helper.dart';
import 'form_data_extension.dart';

class NetworkInterceptor extends Interceptor {
  final bool logIsAllowed;
  final NotificationHelper? notificationHelper;
  NetworkInterceptor({
    this.logIsAllowed = false,
    this.notificationHelper,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final data = (options.data is FormData)
        ? (options.data as FormData).toJson()
        : json.encode(options.data);

    var logRequest = '\nRequest: ${options.baseUrl}${options.path} \n'
        '[Headers] : ${json.encode(options.headers)} \n'
        '[Params] : ${json.encode(options.queryParameters)} \n'
        '[Body] : $data \n';

    if (logIsAllowed) {
      developer.log(logRequest);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var fullUrl = response.requestOptions.uri.toString();
    var logResponse = '\n[Response] (${response.statusCode}) :'
        ' ${json.encode(response.data)}\n';
    if (logIsAllowed) {
      developer.log(logResponse);
    }
    NotificationHelper.showNotification(
      classHashId: notificationHelper.hashCode,
      title: fullUrl,
      message: response.toString(),
      payload: 'putLogIdHere',
    );
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var logError = '\n[Error Message]: ${err.message}';
    if (logIsAllowed) {
      developer.log(logError);
    }

    var errorResponse = '\n[Error Response]'
        '\nHeaders : ${err.response?.headers.toString()}'
        '\nParams: ${err.response?.requestOptions.queryParameters.toString()}'
        '\nData : ${json.encode(err.response?.data)}'
        '\nStacktrace: ${err.stackTrace.toString()}';

    if (logIsAllowed) {
      developer.log(errorResponse);
    }
    handler.next(err);
  }
}
