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

  static ActivityModel toModel(Activity entity) {
    return ActivityModel(
      id: entity.id,
      url: entity.url,
      requestHeader: entity.requestHeader,
      requestBody: entity.requestBody,
      responseHeader: entity.responseHeader,
      responseBody: entity.responseBody,
      responseStatusCode: entity.responseStatusCode,
      responseTime: entity.responseTime,
      responseSize: entity.responseSize,
      createdAt: entity.createdAt,
    );
  }
}
