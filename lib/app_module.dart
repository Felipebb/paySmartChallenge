import 'package:flutter_modular/flutter_modular.dart';

import 'features/upcoming_movies/data/datasources/upcoming_movies_datasource.dart';
import 'features/upcoming_movies/data/repositories/upcoming_movies_repository_impl.dart';
import 'features/upcoming_movies/domain/repositories/upcoming_movies_repository.dart';
import 'features/upcoming_movies/domain/usecases/upcoming_movies_use_case.dart';
import 'features/upcoming_movies/upcoming_movies_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<UpcomingMoviesUseCase>((i) => UpcomingMoviesUseCaseImpl()),
    Bind<UpcomingMoviesRepository>((i) => UpcomingMoviesRepositoryImpl()),
    Bind<UpcomingMoviesDatasource>((i) => UpcomingMoviesDatasource()),
  ];

  final List<ModularRoute> modularRouters = <ModularRoute>[];

  AppModule() {
    modularRouters.addAll([
      ModuleRoute(
        Modular.initialRoute,
        module: UpcomingMoviesModule(),
        transition: TransitionType.noTransition,
      ),
    ]);
  }
}
