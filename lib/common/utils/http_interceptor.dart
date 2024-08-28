import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:http/http.dart';

import '../../domain/entities/http_request.dart';
import '../../domain/entities/http_response.dart';
import '../../network_inspector.dart';
import 'byte_util.dart';
import 'json_util.dart';
import 'url_util.dart';

class HttpInterceptor extends BaseClient {
  final Uri? baseUrl;
  final Map<String, String>? headers;
  final Client client;
  final NetworkInspector? networkInspector;
  final Function(
    int requestHashCode,
    String title,
    String message,
  )? onHttpFinish;
  final bool logIsAllowed;

  HttpInterceptor({
    this.baseUrl,
    this.headers,
    this.networkInspector,
    required this.client,
    this.onHttpFinish,
    this.logIsAllowed = true,
  });

  final _jsonUtil = JsonUtil();
  final _urlUtil = UrlUtil();
  final _byteUtil = ByteUtil();

  @override
  Future<Response> head(
    Uri url, {
    Map<String, String>? headers,
  }) =>
      _sendUnstreamed('HEAD', url, headers);

  @override
  Future<Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) =>
      _sendUnstreamed('GET', url, headers);

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('POST', url, headers, body, encoding);

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PUT', url, headers, body, encoding);

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PATCH', url, headers, body, encoding);

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('DELETE', url, headers, body, encoding);

  @override
  Future<String> read(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final response = await get(
      url,
      headers: headers,
    );
    _checkResponseSuccess(url, response);
    return response.body;
  }

  @override
  Future<Uint8List> readBytes(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final response = await get(
      url,
      headers: headers,
    );
    _checkResponseSuccess(url, response);
    return response.bodyBytes;
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response> _sendUnstreamed(
    String method,
    Uri url,
    Map<String, String>? headers, [
    body,
    Encoding? encoding,
  ]) async {
    var processedHeader = _jsonUtil.compileHeader(this.headers, headers);
    var processedUrl = _urlUtil.isUrlNeedToOveride(baseUrl, url);
    var request = Request(method, processedUrl);

    if (logIsAllowed) {
      saveRequest(request);
    }

    if (processedHeader != null) request.headers.addAll(processedHeader);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }
    if (logIsAllowed) saveRequest(request);
    final response = await Response.fromStream(
      await send(request),
    );

    /// Intercept area
    if (logIsAllowed) {
      saveResponse(response, request.hashCode);
      finishActivity(
        request,
        response,
        request.url.origin.toString(),
        response.body.toString(),
      );
    }
    return response;
  }

  /// Sends an HTTP request and asynchronously returns the response.
  ///
  /// Implementers should call [BaseRequest.finalize] to get the body of the
  /// request as a [ByteStream]. They shouldn't make any assumptions about the
  /// state of the stream; it could have data written to it asynchronously at a
  /// later point, or it could already be closed when it's returned. Any
  /// internal HTTP errors should be wrapped as [ClientException]s.
  @override
  Future<StreamedResponse> send(BaseRequest request) => client.send(request);

  Future<void> logRequest(Request request) async {
    var isNotGet = request.method != 'GET';
    var contentType = (isNotGet) ? request.headers['Content-Type'] : null;
    var logTemplate = '\n[Request url] ${request.url.toString()}'
        '\n[Request header] ${request.headers.toString()}'
        '\n[Request param] ${request.url.queryParameters}'
        '\n[Request body] ${_jsonUtil.encodeRawJson(request.body)}'
        '\n[Request method] ${request.method}'
        '\n[Request content-type] $contentType';
    developer.log(logTemplate);
  }

  Future<void> logResponse(Response response) async {
    var logTemplate = '\n[Response header] ${response.headers.toString()}'
        '\n[Response body] ${_jsonUtil.encodeRawJson(response.body)}'
        '\n[Response code] ${response.statusCode}'
        '\n[Response message] ${response.reasonPhrase}';
    developer.log(logTemplate);
  }

  Future<void> saveRequest(Request request) async {
    var payload = HttpRequest(
      baseUrl: request.url.origin,
      path: request.url.path,
      params: _jsonUtil.encodeRawJson(request.url.queryParameters),
      method: request.method,
      requestHeader: _jsonUtil.encodeRawJson(request.headers),
      requestBody: _jsonUtil.encodeRawJson(request.body),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      requestSize: _byteUtil.stringToBytes(request.body.toString()),
      requestHashCode: request.hashCode,
      cUrl: null
    );
    await networkInspector!.writeHttpRequestLog(payload);
  }

  Future<void> saveResponse(Response response, int requestHashCode) async {
    var payload = HttpResponse(
      createdAt: DateTime.now().millisecondsSinceEpoch,
      responseHeader: _jsonUtil.encodeRawJson(response.headers).toString(),
      responseBody: _jsonUtil.encodeRawJson(response.body).toString(),
      responseStatusCode: response.statusCode,
      responseStatusMessage: response.reasonPhrase.toString(),
      responseSize: _byteUtil.stringToBytes(response.body.toString()),
      requestHashCode: requestHashCode,
        cUrl: null
    );
    await networkInspector!.writeHttpResponseLog(payload);
  }

  Future<void> finishActivity(
    Request request,
    Response response,
    String title,
    String message,
  ) async {
    if (onHttpFinish is Function) {
      await onHttpFinish!(request.hashCode, title, message);
    }
    await logRequest(request);
    await logResponse(response);
  }

  /// Throws an error if [response] is not successful.
  void _checkResponseSuccess(Uri url, Response response) {
    if (response.statusCode < 400) return;
    var message = 'Request to $url failed with status ${response.statusCode}';
    if (response.reasonPhrase != null) {
      message = '$message: ${response.reasonPhrase}';
    }
    throw ClientException('$message.', url);
  }

  @override
  void close() {}
}
