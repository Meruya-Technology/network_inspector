import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/usecase.dart';
import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';

class FetchActivities extends UseCase<List<Activity>?, FetchActivitiesParam?> {
  final LogRepository logRepository;
  FetchActivities({
    required this.logRepository,
  });

  @override
  Future<List<Activity>?> build(FetchActivitiesParam? param) async {
    var result = await logRepository.fetchActivities(
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

class FetchActivitiesParam {
  int? id;
  int? startDate;
  int? endDate;
  String? url;

  FetchActivitiesParam({
    this.id,
    this.startDate,
    this.endDate,
    this.url,
  });
}
