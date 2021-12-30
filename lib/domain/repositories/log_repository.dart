import 'package:network_inspector/domain/entities/activity.dart';

abstract class LogRepository {
  Future<List<Activity>> fetchActivities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  });

  Future<bool> logActivity({
    required Activity activity,
  });
}
