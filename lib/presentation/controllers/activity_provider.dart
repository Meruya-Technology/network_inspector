import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:web_socket_client/web_socket_client.dart' as wsc;

import '../../common/base/data_wrapper.dart';
import '../../common/utils/database_helper.dart';
import '../../domain/entities/http_activity.dart';
import '../../domain/repositories/log_repository.dart';
import '../../domain/usecases/fetch_http_activities.dart';
import '../../infrastructure/datasources/log_datasource.dart';
import '../../infrastructure/datasources/log_datasource_impl.dart';
import '../../infrastructure/repositories/log_repository_impl.dart';
import '../pages/activity_detail_page.dart';
import '../widgets/connect_bottom_sheet.dart';
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

  final scaffoldState = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final ipInputController = TextEditingController();
  final portInputController = TextEditingController(
    text: '8080',
  );
  final serverIdInputController = TextEditingController();
  final deviceInfoPlugin = DeviceInfoPlugin();
  final _connectionController = StreamController<dynamic>.broadcast();
  final _getIt = GetIt.instance;

  Future<String> get brand async =>
      Platform.isAndroid ? (await deviceInfoPlugin.androidInfo).brand : 'Apple';

  Future<String?> get osVersion async =>
      Platform.isAndroid ? await androidVersion : await iosVersion;

  Future<String> get androidVersion async {
    final androidInfo = await deviceInfoPlugin.androidInfo;
    return '${androidInfo.version.release} ${androidInfo.version.codename}';
  }

  Future<String> get iosVersion async {
    final iosInfo = await deviceInfoPlugin.iosInfo;
    return '${iosInfo.systemName} ${iosInfo.systemVersion}';
  }

  Future<String?> get deviceIp async => await NetworkInfo().getWifiIP();
  WebSocket? socket;
  Database? _database;
  FetchHttpActivities? _fetchHttpActivities;
  DataWrapper<List<HttpActivity>> fetchedActivity =
      DataWrapper<List<HttpActivity>>.init();
  ActivityFilterProvider? filterProvider;
  Stream<dynamic> get connectionStatus => _connectionController.stream;

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

  void showConnectBottomSheet() {
    scaffoldState.currentState?.showBottomSheet(
      (context) {
        return ConnectBottomSheet(
          formKey: formKey,
          ipInputController: ipInputController,
          portInputController: portInputController,
          serverIdInputController: serverIdInputController,
          onConnectTap: connectWebSocket,
        );
      },
    );
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
      retrieveResponseStatusCodesFilter(result);
      notifyListeners();
    } catch (error) {
      fetchedActivity = DataWrapper.error(
        message: error.toString(),
      );
    }
  }

  void retrieveResponseStatusCodesFilter(
    List<HttpActivity> httpActivities,
  ) {
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

  void onIpInputClear() {
    ipInputController.clear();
  }

  Future<void> connectWebSocket() async {
    if (formKey.currentState?.validate() ?? false) {
      final ip = ipInputController.text;
      final port = portInputController.text;
      socket = WebSocket(
        Uri.parse(
          'ws://$ip:$port',
        ),
      );

      if (socket != null && !_getIt.isRegistered<WebSocket>()) {
        _getIt.registerSingleton<WebSocket>(
          socket!,
        );
      }

      socket?.messages.listen(
        (message) {
          debugPrint('[Web Socket] Message: $message');
        },
        onError: (error) {
          debugPrint('[Web Socket] ERROR: $error');
        },
        onDone: () {
          debugPrint('[Web Socket] Connection closed');
        },
      );

      socket?.connection.listen(
        (state) {
          updateConnectionStatus(state);
        },
      );
    }
  }

  // Method to update connection status
  Future<void> updateConnectionStatus(wsc.ConnectionState status) async {
    _connectionController.add(status);
    if (status is Connected) {
      final clientId = await deviceIp;
      socket!.send(
        jsonEncode(
          {
            'clientId': clientId,
            'roomId': serverIdInputController.text,
            'metadata': {
              'clientType': 'client',
              'actionType': 'connected',
            },
            'payload': {
              'brand': await brand,
              'osVersion': await osVersion,
            },
          },
        ),
      );
    }
  }

  Future<void> disconnect() async {
    final clientId = await deviceIp;
    final payload = jsonEncode({
      'clientId': clientId,
      'roomId': serverIdInputController.text,
      'metadata': {
        'clientType': 'client',
        'actionType': 'disconnect',
      },
      'payload': {},
    });
    socket?.close(
      1000,
      payload,
    );
  }
}
