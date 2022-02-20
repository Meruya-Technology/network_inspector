import '../models/base_response_model.dart';

import '../models/fetch_planet_response_model.dart';

abstract class PlanetDatasource {
  Future<FetchPlanetResponseModel?> fetchPlanet();
  Future<BaseResponseModel?> createPlanet({
    required String name,
    required String description,
  });
}
