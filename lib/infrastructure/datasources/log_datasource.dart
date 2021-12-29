import 'package:network_inspector/infrastructure/models/activity_model.dart';

abstract class LogDatasource {
  Future<ActivityModel?> activities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  });

  Future<ActivityModel?> logActivity({
    required ActivityModel activityModel,
  });
}
