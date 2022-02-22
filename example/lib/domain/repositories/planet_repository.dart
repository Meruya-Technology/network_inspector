import '../entities/planet.dart';

abstract class PlanetRepository {
  Future<List<Planet>?> fetchPlanet();
  Future<String?> createPlanet({
    required String name,
    required String description,
  });
}
