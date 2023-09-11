import 'package:flutter/material.dart';
import '../../common/utils/use_case.dart';
import '../entities/http_response.dart';
import '../repositories/log_repository.dart';

/// @nodoc
class FetchHttpResponses extends UseCase<List<HttpResponse>?, int> {
  final LogRepository logRepository;
  FetchHttpResponses({
    required this.logRepository,
  });

  @override
  Future<List<HttpResponse>?> build(int param) async {
    var result = await logRepository.httpResponses(
      requestHashCode: param,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint('$error');
  }
}
