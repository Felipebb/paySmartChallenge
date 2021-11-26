import '../../domain/entities/dates.dart';
import '../../domain/entities/upcoming_movies.dart';

import '../../domain/entities/upcoming_movies_list.dart';
import 'dates_model.dart';
import 'upcoming_movies_model.dart';

class UpcomingMoviesListModel extends UpcomingMoviesList {
  UpcomingMoviesListModel(Dates? dates, int page, List<UpcomingMovies>? results,
      int totalPages, int totalResults)
      : super(
            dates: dates,
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults);

  UpcomingMoviesListModel.fromJson(Map<String, dynamic> json) {
    dates = (json['dates'] != null ? DatesModel.fromJson(json['dates']) : null);
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results!.add(UpcomingMoviesModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}
