import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/usecase.dart';
import 'package:network_inspector/domain/entities/http_response.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';

class FetchHttpResponses extends UseCase<List<HttpResponse>?, int> {
  final LogRepository logRepository;
  FetchHttpResponses({
    required this.logRepository,
  });

  @override
  Future<List<HttpResponse>?> build(int requestHashCode) async {
    var result = await logRepository.httpResponses(
      requestHashCode: requestHashCode,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint('$error');
  }
}
