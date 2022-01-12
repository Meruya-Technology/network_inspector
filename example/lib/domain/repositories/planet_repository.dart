import 'package:example/domain/entities/planet.dart';

abstract class PlanetRepository {
  Future<List<Planet>?> fetchPlanet();
}
