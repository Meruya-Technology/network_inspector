import 'package:flutter/material.dart';
import '../../common/utils/use_case.dart';
import '../entities/http_request.dart';
import '../repositories/log_repository.dart';

/// @nodoc
class LogHttpRequest extends UseCase<bool, HttpRequest> {
  final LogRepository logRepository;
  LogHttpRequest({
    required this.logRepository,
  });

  @override
  Future<bool> build(HttpRequest param) async {
    var result = await logRepository.logHttpRequest(
      httpRequestModel: param,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint(error);
  }
}
