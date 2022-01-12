import 'package:example/common/datasource_client.dart';
import 'package:example/infrastructure/datasources/planet_datasource.dart';
import 'package:example/infrastructure/models/fetch_planet_response_model.dart';

class PlanetDatasourceImpl implements PlanetDatasource {
  final DatasourceClient datasourceClient;
  PlanetDatasourceImpl({
    required this.datasourceClient,
  });

  Future<FetchPlanetResponseModel?> fetchPlanet() async {
    switch (datasourceClient.datasourceClientType) {
      case DatasourceClientType.Dio:
        return null;
      case DatasourceClientType.Http:
        return null;
      case DatasourceClientType.Vanilla:
        return null;
    }
  }
}
