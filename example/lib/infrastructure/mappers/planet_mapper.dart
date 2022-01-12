import 'package:example/domain/entities/planet.dart';
import 'package:example/infrastructure/models/planet_model.dart';

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
