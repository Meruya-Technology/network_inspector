import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/planet.dart';
import '../../domain/repositories/planet_repository.dart';
import '../../domain/usecases/create_planet.dart';
import '../../domain/usecases/fetch_planet.dart';
import '../../infrastructure/datasources/planet_datasource.dart';
import '../../infrastructure/datasources/planet_datasource_impl.dart';
import '../../infrastructure/repositories/planet_repository_impl.dart';
import 'main_provider.dart';

class DioProvider extends ChangeNotifier {
  final BuildContext context;
  DioProvider({
    required this.context,
  }) {
    injectDependencies();
  }
  PlanetDatasource? planetDatasource;
  PlanetRepository? planetRepository;
  FetchPlanet? fetchPlanet;
  CreatePlanet? createPlanet;
  MainProvider get mainProvider {
    return Provider.of<MainProvider>(
      context,
      listen: false,
    );
  }

  Future<void> injectDependencies() async {
    planetDatasource = PlanetDatasourceImpl(
      datasourceClient: mainProvider.dioClient,
    );
    planetRepository = PlanetRepositoryImpl(
      planetDatasource: planetDatasource!,
    );
    fetchPlanet = FetchPlanet(
      planetRepository: planetRepository!,
    );
    createPlanet = CreatePlanet(
      planetRepository: planetRepository!,
    );
  }

  Future<List<Planet>?> retrievePlanet() async {
    return fetchPlanet!.execute();
  }
}
