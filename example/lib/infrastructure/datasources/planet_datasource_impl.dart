import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:network_inspector/common/utils/url_util.dart';

import '../../const/endpoint.dart';
import '../models/base_response_model.dart';
import '../models/fetch_planet_response_model.dart';
import 'planet_datasource.dart';

class PlanetDatasourceImpl implements PlanetDatasource {
  final dynamic datasourceClient;
  PlanetDatasourceImpl({
    required this.datasourceClient,
  });

  final _urlUtil = UrlUtil();

  @override
  Future<FetchPlanetResponseModel?> fetchPlanet() async {
    var queryMap = {'id': '1'};
    var headers = {'Authorization': 'Bearer test123'};

    if (datasourceClient is Dio) {
      var response = await (datasourceClient as Dio).get(
        Endpoint.planet,
        queryParameters: queryMap,
      );
      return (response.data != null)
          ? FetchPlanetResponseModel.fromJson(response.data)
          : null;
    } else if (datasourceClient is Client) {
      var queryParam = _urlUtil.mapToQuery(queryMap);
      var url = Uri.parse('${Endpoint.planet}?$queryParam');
      var response = await (datasourceClient as Client).get(
        url,
        headers: headers,
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
    var request = {
      'name': name,
      'description': description,
    };
    if (datasourceClient is Dio) {
      var response = await (datasourceClient as Dio).post(
        Endpoint.planet,
        data: request,
      );
      return (response.data != null)
          ? BaseResponseModel.fromJson(response.data)
          : null;
    } else if (datasourceClient is Client) {
      var response = await (datasourceClient as Client).post(
        Uri.parse(Endpoint.planet),
        body: jsonEncode(request),
      );
      return (response.body != '')
          ? BaseResponseModel.fromJson(
              jsonDecode(response.body),
            )
          : null;
    } else {
      throw UnimplementedError();
    }
  }
}
