import '../entities/planet.dart';
import '../repositories/planet_repository.dart';

class FetchPlanet {
  final PlanetRepository planetRepository;
  FetchPlanet({
    required this.planetRepository,
  });

  Future<List<Planet>?> execute() {
    return planetRepository.fetchPlanet();
  }
}
