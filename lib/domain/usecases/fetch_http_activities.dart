import 'package:flutter/material.dart';

import '../../common/utils/use_case.dart';
import '../entities/http_activity.dart';
import '../repositories/log_repository.dart';

class FetchHttpActivities
    extends UseCase<List<HttpActivity>?, FetchHttpActivitysParam?> {
  final LogRepository logRepository;
  FetchHttpActivities({
    required this.logRepository,
  });

  @override
  Future<List<HttpActivity>?> build(FetchHttpActivitysParam? param) async {
    var result = await logRepository.httpActivities(
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

class FetchHttpActivitysParam {
  int? startDate;
  int? endDate;
  String? url;

  FetchHttpActivitysParam({
    this.url,
    this.startDate,
    this.endDate,
  });
}
