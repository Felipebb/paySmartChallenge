import 'dates.dart';

import 'upcoming_movies.dart';

class UpcomingMoviesList {
  Dates? dates;
  int? page;
  List<UpcomingMovies>? results;
  int? totalPages;
  int? totalResults;

  UpcomingMoviesList(
      {this.dates,
      this.page,
      this.results,
      this.totalPages,
      this.totalResults});
}
