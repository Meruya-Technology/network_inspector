import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/network_inspector_infrastructure.dart';

class ActivityMapper {
  static Activity toEntity(ActivityModel model) {
    return Activity(
      id: model.id,
      url: model.url,
      requestHeader: model.requestHeader,
      requestBody: model.requestBody,
      responseHeader: model.responseHeader,
      responseBody: model.responseBody,
      responseStatusCode: model.responseStatusCode,
      responseTime: model.responseTime,
      responseSize: model.responseSize,
      createdAt: model.createdAt,
    );
  }
}
