import 'package:flutter_modular/flutter_modular.dart';

import '../../data/models/upcoming_movies_list_model.dart';
import '../repositories/upcoming_movies_repository.dart';

abstract class UpcomingMoviesUseCase {
  Future<UpcomingMoviesListModel> getUpcomingMovies(int pageNumber);
}

class UpcomingMoviesUseCaseImpl implements UpcomingMoviesUseCase {
  final UpcomingMoviesRepository upcomingMoviesRepository =
      Modular.get<UpcomingMoviesRepository>();

  @override
  Future<UpcomingMoviesListModel> getUpcomingMovies(int pageNumber) async {
    return await upcomingMoviesRepository.getUpcomingMovies(pageNumber);
  }
}
