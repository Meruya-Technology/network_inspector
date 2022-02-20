import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart';

import '../../const/endpoint.dart';
import '../models/base_response_model.dart';
import '../models/fetch_planet_response_model.dart';
import 'planet_datasource.dart';

class PlanetDatasourceImpl implements PlanetDatasource {
  final dynamic datasourceClient;
  PlanetDatasourceImpl({
    required this.datasourceClient,
  });

  @override
  Future<FetchPlanetResponseModel?> fetchPlanet() async {
    if (datasourceClient is Dio) {
      var response = await (datasourceClient as Dio).get(
        Endpoint.planet,
        queryParameters: {'id': 1},
      );
      return (response.data != null)
          ? FetchPlanetResponseModel.fromJson(response.data)
          : null;
    } else if (datasourceClient is Client) {
      var response = await (datasourceClient as Client).get(
        Uri.parse(
          Endpoint.planet,
        ),
      );
      return (response.body != '')
          ? FetchPlanetResponseModel.fromJson(
              jsonDecode(response.body),
            )
          : null;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<BaseResponseModel?> createPlanet({
    required String name,
    required String description,
  }) async {
    if (datasourceClient is Dio) {
      var request = {
        'name': name,
        'description': description,
      };
      var response = await (datasourceClient as Dio).post(
        Endpoint.planet,
        data: request,
      );
      return (response.data != null)
          ? BaseResponseModel.fromJson(response.data)
          : null;
    } else if (datasourceClient is Client) {
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }
}
