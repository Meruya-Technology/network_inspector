import '../../domain/entities/planet.dart';
import '../models/planet_model.dart';

class PlanetMapper {
  static Planet toEntity(PlanetModel model) {
    return Planet(
      id: model.id,
      name: model.name,
      description: model.description,
      image: model.image,
    );
  }
}
