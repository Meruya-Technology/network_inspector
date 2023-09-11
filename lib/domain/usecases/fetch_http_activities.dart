import 'package:flutter/material.dart';

import '../../common/utils/use_case.dart';
import '../entities/http_activity.dart';
import '../repositories/log_repository.dart';

/// @nodoc
class FetchHttpActivities
    extends UseCase<List<HttpActivity>?, FetchHttpActivitiesParam?> {
  final LogRepository logRepository;

  FetchHttpActivities({
    required this.logRepository,
  });

  @override
  Future<List<HttpActivity>?> build(FetchHttpActivitiesParam? param) async {
    var result = await logRepository.httpActivities(
      url: param?.url,
      startDate: param?.startDate,
      statusCodes: param?.statusCodes,
      endDate: param?.endDate,
    );
    return result;
  }

  Future<bool> deleteHttpActivities() async {
    var result = await logRepository.deleteHttpActivities();
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint('$error');
  }
}

class FetchHttpActivitiesParam {
  int? startDate;
  int? endDate;
  List<int?>? statusCodes;
  String? url;

  FetchHttpActivitiesParam({
    this.url,
    this.startDate,
    this.statusCodes,
    this.endDate,
  });
}
