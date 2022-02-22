import '../repositories/planet_repository.dart';

class CreatePlanet {
  final PlanetRepository planetRepository;
  CreatePlanet({
    required this.planetRepository,
  });

  Future<String?> execute({
    required String name,
    required String description,
  }) {
    return planetRepository.createPlanet(
      name: name,
      description: description,
    );
  }
}
