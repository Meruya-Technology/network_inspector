import 'package:flutter/material.dart';
import '../../common/utils/use_case.dart';
import '../entities/http_request.dart';
import '../repositories/log_repository.dart';

/// @nodoc
class FetchHttpRequests extends UseCase<List<HttpRequest>?, int?> {
  final LogRepository logRepository;
  FetchHttpRequests({
    required this.logRepository,
  });

  @override
  Future<List<HttpRequest>?> build(int? param) async {
    var result = await logRepository.httpRequests(
      requestHashCode: param,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint('$error');
  }
}
