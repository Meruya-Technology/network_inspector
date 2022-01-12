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
    var result = await logRepository.logActivity(
      activity: Activity(
        url: param.url,
        method: param.method,
        requestBody: param.requestBody,
        requestHeader: param.requestHeader,
        responseBody: param.responseBody,
        responseHeader: param.responseHeader,
        responseStatusCode: param.responseStatusCode,
        responseStatusMessage: param.responseStatusMessage,
        responseTime: param.responseTime,
        responseSize: param.responseSize,
        createdAt: param.createdAt,
      ),
    );
    return result;
  }

  @override
  Future<void> handleError(error) async {
    debugPrint(error);
  }
}

class LogActivityParam {
  final String? url;
  final String? method;
  final String? requestHeader;
  final String? requestBody;
  final String? responseHeader;
  final String? responseBody;
  final int? responseStatusCode;
  final String? responseStatusMessage;
  final String? responseTime;
  final String? responseSize;
  final int? createdAt;

  LogActivityParam({
    this.url,
    this.method,
    this.requestHeader,
    this.requestBody,
    this.responseHeader,
    this.responseBody,
    this.responseStatusCode,
    this.responseStatusMessage,
    this.responseTime,
    this.responseSize,
    this.createdAt,
  });
}
