import 'package:flutter/material.dart';
import 'package:network_inspector/common/utils/database_helper.dart';
import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';
import 'package:network_inspector/domain/usecases/fetch_activities.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource_impl.dart';
import 'package:network_inspector/infrastructure/repositories/log_repository_impl.dart';
import 'package:sqflite/sqflite.dart';

class ActivityProvider extends ChangeNotifier {
  final BuildContext context;

  ActivityProvider({
    required this.context,
  }) {
    injectDependencies().whenComplete(() {
      initState();
    });
  }

  Database? _database;
  FetchActivities? _fetchActivities;
  Future<List<Activity>?>? fetchedActivity;

  Future<void> injectDependencies() async {
    _database = await DatabaseHelper.initialize();
    if (_database != null) {
      LogDatasource logDatasource = LogDatasourceImpl(
        database: _database!,
      );
      LogRepository logRepository = LogRepositoryImpl(
        logDatasource: logDatasource,
      );
      _fetchActivities = FetchActivities(
        logRepository: logRepository,
      );
    }
  }

  Future<void> initState() async {
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    fetchedActivity = _fetchActivities?.execute(null).whenComplete(() {
      notifyListeners();
    });
  }
}
