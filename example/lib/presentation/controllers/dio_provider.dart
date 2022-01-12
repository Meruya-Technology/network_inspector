import 'package:example/domain/entities/planet.dart';
import 'package:example/domain/repositories/planet_repository.dart';
import 'package:example/domain/usecases/fetch_planet.dart';
import 'package:example/infrastructure/datasources/planet_datasource.dart';
import 'package:example/infrastructure/datasources/planet_datasource_impl.dart';
import 'package:example/infrastructure/repositories/planet_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  Future<List<Planet>?> retrievePlanet() async {
    return fetchPlanet!.execute();
  }
}
