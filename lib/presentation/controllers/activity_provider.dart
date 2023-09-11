import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/base/data_wrapper.dart';
import '../../common/utils/database_helper.dart';
import '../../domain/entities/http_activity.dart';
import '../../domain/repositories/log_repository.dart';
import '../../domain/usecases/fetch_http_activities.dart';
import '../../infrastructure/datasources/log_datasource.dart';
import '../../infrastructure/datasources/log_datasource_impl.dart';
import '../../infrastructure/repositories/log_repository_impl.dart';
import '../pages/activity_detail_page.dart';
import 'activity_filter_provider.dart';

/// @nodoc
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
  DataWrapper<List<HttpActivity>> fetchedActivity =
      DataWrapper<List<HttpActivity>>.init();
  ActivityFilterProvider? filterProvider;

  /// Filter variables
  ///
  /// Stores available status code with its amount
  Map<int?, int> statusCodes = {};

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
      filterProvider = ActivityFilterProvider();
    }
  }

  Future<void> initState() async {
    fetchActivities();
  }

  void filterHttpActivities(List<int?> filterList) {
    fetchActivities(statusCodes: filterList);
  }

  Future<void> fetchActivities({
    List<int?>? statusCodes,
  }) async {
    try {
      fetchedActivity = DataWrapper.loading();
      final result = await _fetchHttpActivities?.execute(statusCodes != null
              ? FetchHttpActivitiesParam(
                  statusCodes: statusCodes,
                )
              : null) ??
          [];
      fetchedActivity = DataWrapper.success(result);
      retrieveResponseStatusCodeListFilter(result);
      notifyListeners();
    } catch (error) {
      fetchedActivity = DataWrapper.error(
        message: error.toString(),
      );
    }
  }

  void retrieveResponseStatusCodeListFilter(List<HttpActivity> httpActivities) {
    final groupedActivity = httpActivities.groupListsBy((activity) {
      return activity.response?.responseStatusCode;
    });
    for (final element in groupedActivity.entries) {
      statusCodes[element.key] = element.value.length;
    }
  }

  Future<void> deleteActivities() async {
    await _fetchHttpActivities?.deleteHttpActivities();
    fetchActivities();
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
}
