import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/usecase.dart';
import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';

class LogActivity extends UseCase<bool, LogActivityParam> {
  final LogRepository logRepository;
  LogActivity({
    required this.logRepository,
  });

  @override
  Future<bool> build(LogActivityParam param) async {
    var result = await logRepository.logActivity(activity: Activity());
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint(error);
  }
}

class LogActivityParam {
  final String? url;
  final String? requestHeader;
  final String? requestBody;
  final String? responseHeader;
  final String? responseBody;
  final String? responseStatusCode;
  final String? responseTime;
  final String? responseSize;
  final int? createdAt;

  LogActivityParam({
    this.url,
    this.requestHeader,
    this.requestBody,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseTime,
    this.responseSize,
    this.createdAt,
  });
}
