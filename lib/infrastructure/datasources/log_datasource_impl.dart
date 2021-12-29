import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/models/activity_model.dart';

class LogDatasourceImpl extends LogDatasource {
  Future<ActivityModel?> activities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  }) {
    return Future.value();
  }

  @override
  Future<ActivityModel?> logActivity({
    required ActivityModel activityModel,
  }) {
    throw UnimplementedError();
  }
}
