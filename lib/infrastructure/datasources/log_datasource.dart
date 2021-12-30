import 'package:network_inspector/infrastructure/models/activity_model.dart';

abstract class LogDatasource {
  Future<List<ActivityModel>> activities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  });

  Future<bool> logActivity({
    required ActivityModel activityModel,
  });
}
