import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/mappers/activity_mapper.dart';

class LogRepositoryImpl implements LogRepository {
  final LogDatasource logDatasource;
  LogRepositoryImpl({
    required this.logDatasource,
  });

  Future<List<Activity>> fetchActivities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  }) async {
    var models = await logDatasource.activities(
      id: id,
      url: url,
      startDate: startDate,
      endDate: endDate,
    );
    var entities = List<Activity>.from(
      models.map(
        (model) => ActivityMapper.toEntity(
          model,
        ),
      ),
    );
    return entities;
  }

  @override
  Future<bool> logActivity({
    required Activity activity,
  }) async {
    var model = ActivityMapper.toModel(activity);
    var result = await logDatasource.logActivity(
      activityModel: model,
    );
    return result;
  }
}
