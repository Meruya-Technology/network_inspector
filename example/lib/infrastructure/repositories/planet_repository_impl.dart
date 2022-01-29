import '../../domain/entities/planet.dart';
import '../../domain/repositories/planet_repository.dart';
import '../datasources/planet_datasource.dart';
import '../mappers/planet_mapper.dart';

class PlanetRepositoryImpl implements PlanetRepository {
  final PlanetDatasource planetDatasource;
  PlanetRepositoryImpl({
    required this.planetDatasource,
  });

  @override
  Future<List<Planet>?> fetchPlanet() async {
    var models = await planetDatasource.fetchPlanet();
    var result = (models?.data != null)
        ? List<Planet>.from(
            models!.data.map(
              (model) => PlanetMapper.toEntity(model),
            ),
          )
        : null;
    return result;
  }
}
