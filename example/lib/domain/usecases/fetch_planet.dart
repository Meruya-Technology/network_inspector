import 'package:example/domain/entities/planet.dart';
import 'package:example/domain/repositories/planet_repository.dart';

class FetchPlanet {
  final PlanetRepository planetRepository;
  FetchPlanet({
    required this.planetRepository,
  });

  Future<List<Planet>?> fetchPlanet() {
    return planetRepository.fetchPlanet();
  }
}
