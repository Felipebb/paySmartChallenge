import '../../domain/repositories/upcoming_movies_repository.dart';
import '../datasources/upcoming_movies_datasource.dart';
import '../models/upcoming_movies_list_model.dart';

class UpcomingMoviesRepositoryImpl implements UpcomingMoviesRepository {
  final UpcomingMoviesDatasource upcomingMoviesDatasource =
      UpcomingMoviesDatasource();
  @override
  Future<UpcomingMoviesListModel> getUpcomingMovies(int pageNumber) async {
    return await upcomingMoviesDatasource.getMovies(pageNumber);
  }
}
