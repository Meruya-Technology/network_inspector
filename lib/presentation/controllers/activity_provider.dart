import 'package:flutter/material.dart';
import 'package:network_inspector/domain/entities/http_activity.dart';
import 'package:network_inspector/domain/usecases/fetch_http_activities.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/utils/database_helper.dart';
import '../../domain/entities/http_request.dart';
import '../../domain/repositories/log_repository.dart';
import '../../domain/usecases/fetch_http_requests.dart';
import '../../infrastructure/datasources/log_datasource.dart';
import '../../infrastructure/datasources/log_datasource_impl.dart';
import '../../infrastructure/repositories/log_repository_impl.dart';

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
  FetchHttpActivities? _fetchHttpActivities;
  Future<List<HttpActivity>?>? fetchedActivity;

  Future<void> injectDependencies() async {
    _database = await DatabaseHelper.initialize();
    if (_database != null) {
      LogDatasource logDatasource = LogDatasourceImpl(
        database: _database!,
      );
      LogRepository logRepository = LogRepositoryImpl(
        logDatasource: logDatasource,
      );
      _fetchHttpActivities = FetchHttpActivities(
        logRepository: logRepository,
      );
    }
  }

  Future<void> initState() async {
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    fetchedActivity = _fetchHttpActivities?.execute(null).whenComplete(() {
      notifyListeners();
    });
  }
}
