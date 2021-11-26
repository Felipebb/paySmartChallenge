import 'package:dio/dio.dart';

import '../../../../constants.dart';
import '../models/upcoming_movies_list_model.dart';

class UpcomingMoviesDatasource {
  final Dio httpClient = Dio();

  Future<UpcomingMoviesListModel> getMovies(int pageNumber) async {
    var apikey = "api_key=2a6fab3778e53fa5fb4c08913d7ee765";
    var url = apiBaseUrl + apikey + "&page=$pageNumber";
    var response =
        await httpClient.get(url, queryParameters: {"page": pageNumber});
    if (response.statusCode == 200) {
      return UpcomingMoviesListModel.fromJson(response.data);
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}
