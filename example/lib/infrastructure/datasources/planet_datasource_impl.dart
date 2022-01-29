import 'package:dio/dio.dart';
import 'package:http/http.dart';

import '../../const/endpoint.dart';
import '../models/fetch_planet_response_model.dart';
import 'planet_datasource.dart';

class PlanetDatasourceImpl implements PlanetDatasource {
  final dynamic datasourceClient;
  PlanetDatasourceImpl({
    required this.datasourceClient,
  });

  Future<FetchPlanetResponseModel?> fetchPlanet() async {
    if (datasourceClient is Dio) {
      var response = await (datasourceClient as Dio).get(
        Endpoint.planet,
        queryParameters: {
          'id': 1,
        },
      );
      return (response.data != null)
          ? FetchPlanetResponseModel.fromJson(response.data)
          : null;
    } else if (datasourceClient is Client) {
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }
}
