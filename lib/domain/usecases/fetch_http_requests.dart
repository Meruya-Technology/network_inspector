import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/usecase.dart';
import 'package:network_inspector/domain/entities/http_request.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';

class FetchHttpRequests
    extends UseCase<List<HttpRequest>?, FetchHttpRequestsParam?> {
  final LogRepository logRepository;
  FetchHttpRequests({
    required this.logRepository,
  });

  @override
  Future<List<HttpRequest>?> build(FetchHttpRequestsParam? param) async {
    var result = await logRepository.httpRequests(
      id: param?.id,
      url: param?.url,
      startDate: param?.startDate,
      endDate: param?.endDate,
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint('$error');
  }
}

class FetchHttpRequestsParam {
  int? id;
  int? startDate;
  int? endDate;
  String? url;

  FetchHttpRequestsParam({
    this.id,
    this.startDate,
    this.endDate,
    this.url,
  });
}
