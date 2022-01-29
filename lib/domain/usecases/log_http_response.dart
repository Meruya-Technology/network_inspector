import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/usecase.dart';
import 'package:network_inspector/domain/entities/http_response.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';

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
