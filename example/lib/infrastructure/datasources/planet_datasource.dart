import '../models/fetch_planet_response_model.dart';

abstract class PlanetDatasource {
  Future<FetchPlanetResponseModel?> fetchPlanet();
}
