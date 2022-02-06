import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/http_activity.dart';
import '../../domain/repositories/log_repository.dart';
import '../../domain/usecases/fetch_http_activities.dart';
import '../../infrastructure/datasources/log_datasource.dart';
import '../../infrastructure/datasources/log_datasource_impl.dart';
import '../../infrastructure/repositories/log_repository_impl.dart';
import '../../network_inspector.dart';

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

  Future<void> goToDetailActivity(HttpActivity httpActivity) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => ActivityDetailPage(
          httpActivity: httpActivity,
        ),
      ),
    );
  }

  String totalTransferSize(
    int? requestSize,
    int? responseSize,
    bool isRaw,
  ) {
    var reqSize = requestSize ?? 0;
    var resSize = responseSize ?? 0;
    var rawTotalSize = reqSize + resSize;
    var totalSize =
        (!isRaw) ? (rawTotalSize / 1024).toStringAsFixed(2) : rawTotalSize;
    return '$totalSize kb';
  }
}
