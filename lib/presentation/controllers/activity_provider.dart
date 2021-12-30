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
    print('initialize');
    injectDependencies().whenComplete(() {
      initState();
    });
  }

  Database? database;
  FetchActivities? fetchActivities;
  Future<List<Activity>?>? fetchedActivity;

  Future<void> injectDependencies() async {
    database = await DatabaseHelper.initialize();
    if (database != null) {
      LogDatasource logDatasource = LogDatasourceImpl(
        database: database!,
      );
      LogRepository logRepository = LogRepositoryImpl(
        logDatasource: logDatasource,
      );
      fetchActivities = FetchActivities(
        logRepository: logRepository,
      );
    }
  }

  Future<void> initState() async {
    fetchedActivity = fetchActivities?.execute(null).whenComplete(() {
      notifyListeners();
    });
  }
}
