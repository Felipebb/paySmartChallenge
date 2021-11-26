import 'domain/usecases/upcoming_movies_use_case.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'data/repositories/upcoming_movies_repository_impl.dart';
import 'domain/repositories/upcoming_movies_repository.dart';

class UpcomingMoviesModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<UpcomingMoviesUseCase>((i) => UpcomingMoviesUseCaseImpl()),
    Bind<UpcomingMoviesRepository>((i) => UpcomingMoviesRepositoryImpl()),
  ];
}
