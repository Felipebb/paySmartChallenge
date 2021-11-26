import '../../data/models/upcoming_movies_list_model.dart';

abstract class UpcomingMoviesRepository {
  Future<UpcomingMoviesListModel> getUpcomingMovies(int pageNumber);
}
