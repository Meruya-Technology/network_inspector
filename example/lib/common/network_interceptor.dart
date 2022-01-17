import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:example/common/notification_helper.dart';
import 'package:intl/intl.dart';
import 'package:network_inspector/domain/usecases/log_activity.dart';
import 'package:network_inspector/network_inspector.dart';
import 'form_data_extension.dart';
import 'dart:typed_data';

class NetworkInterceptor extends Interceptor {
  final bool logIsAllowed;
  final NotificationHelper? notificationHelper;
  final NetworkInspector? networkInspector;

  NetworkInterceptor({
    this.logIsAllowed = false,
    this.notificationHelper,
    this.networkInspector,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final data = (options.data is FormData)
        ? (options.data as FormData).toJson()
        : json.encode(options.data);

    var newOption = options.copyWith(
      extra: {
        'date': new DateTime.now(),
      },
    );

    var logRequest = '\nRequest: ${newOption.baseUrl}${newOption.path} \n'
        '[Headers] : ${json.encode(newOption.headers)} \n'
        '[Params] : ${json.encode(newOption.queryParameters)} \n'
        '[Body] : $data \n';

    if (logIsAllowed) {
      developer.log(logRequest);
    }
    handler.next(newOption);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    logActivity(response);
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

  Future<void> logRequest(RequestOptions request) async {
    var logTemplate = '\n[Request url] ${request.uri.toString()}'
        '\n[Request header] ${request.headers.toString()}'
        '\n[Request param] ${request.queryParameters}'
        '\n[Request body] ${json.encode(request.data)}'
        '\n[Request method] ${request.method}'
        '\n[Request content-type] ${request.contentType}';
    developer.log(logTemplate);
  }

  Future<void> logResponse(Response response) async {
    var logTemplate = '\n[Response header] ${response.headers.toString()}'
        '\n[Response body] ${json.encode(response.data)}'
        '\n[Response code] ${response.statusCode}'
        '\n[Response message] ${response.statusMessage}'
        '\n[Response extra] ${response.extra}';
    developer.log(logTemplate);
  }

  Future<void> logActivity(Response response) async {
    const dateFormat = "EEE, d MMM y H:m:s Z";

    var request = response.requestOptions;
    var fullUrl = request.uri.toString();

    var headersMap = response.headers.map;
    var responseBody = response.toString();
    var responseDate = headersMap['date']?.first;
    var parsedResponseDate = DateFormat(dateFormat).parse(responseDate!, false);
    var localResponseDate = parsedResponseDate.add(Duration(hours: 7));

    if (logIsAllowed) {
      await logRequest(request);
      await logResponse(response);

      var activity = LogActivityParam(
        url: fullUrl,
        method: request.method,
        requestBody: request.data.toString(),
        requestHeader: headersMap.toString(),
        responseBody: responseBody,
        responseHeader: response.headers.toString(),
        responseStatusCode: response.statusCode,
        responseStatusMessage: response.statusMessage,
        createdAt: localResponseDate.millisecondsSinceEpoch,
      );
      await networkInspector!.log(activity).whenComplete(() {
        notifyResponse(
          title: fullUrl,
          message: response.toString(),
        );
      });
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
