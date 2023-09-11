import 'package:flutter/material.dart';
import '../../common/utils/use_case.dart';
import '../entities/http_response.dart';
import '../repositories/log_repository.dart';

/// @nodoc
class LogHttpResponse extends UseCase<bool, HttpResponse> {
  final LogRepository logRepository;
  LogHttpResponse({
    required this.logRepository,
  });

  @override
  Future<bool> build(HttpResponse param) async {
    var result = await logRepository.logHttpResponse(
      httpResponseModel: param,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint(error);
  }
}
