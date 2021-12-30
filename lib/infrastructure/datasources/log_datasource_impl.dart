import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/models/activity_model.dart';
import 'package:sqflite/sqflite.dart';

class LogDatasourceImpl implements LogDatasource {
  final Database database;
  LogDatasourceImpl({
    required this.database,
  });

  Future<List<ActivityModel>?> activities({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  }) async {
    List<Map<String, Object?>> rows = await database.query(
      ActivityModel.tableName,
    );
    var models = List<ActivityModel>.from(
      rows.map(
        (row) => ActivityModel.fromJson(row),
      ),
    );
    return models;
  }

  @override
  Future<bool> logActivity({
    required ActivityModel activityModel,
  }) async {
    var id = await database.insert(
      ActivityModel.tableName,
      activityModel.toJson(),
    );
    return (id != 0);
  }
}
