import 'dart:async';

import '../../domain/entities/upcoming_movies_list.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/models/upcoming_movies_list_model.dart';
import '../../domain/usecases/upcoming_movies_use_case.dart';

class MoviesListBloc {
//!Dependency Injection
  UpcomingMoviesUseCase upcomingMoviesUseCase =
      Modular.get<UpcomingMoviesUseCase>();
//!
  int _pageNumber = 0;
  bool isLoadingNewsPage = false;
  bool hasMoreItems = true;

  final subject = StreamController();
  Stream get movieStream => subject.stream;

  UpcomingMoviesListModel auxResponse =
      UpcomingMoviesListModel(null, 0, [], 0, 0);

  get movies => auxResponse.results;

  getMovies() async {
    if (!isLoadingNewsPage) {
      isLoadingNewsPage = true;
      ++_pageNumber;
      try {
        UpcomingMoviesList response =
            await upcomingMoviesUseCase.getUpcomingMovies(_pageNumber);

        hasMoreItems = auxResponse.results!.isNotEmpty;
        auxResponse.results!.addAll(response.results!);
        subject.sink.add(auxResponse.results);
      } on Exception {
        subject.sink.addError(500);
      }

      isLoadingNewsPage = false;
    }
    if (_pageNumber == 1) {
      getMovies();
    }
  }

  getFilteredMovieList(String? filter) {
    var filteredMovieList = auxResponse.results!.where((element) {
      return element.title!.toLowerCase().contains(filter!.toLowerCase());
    }).toList();
    if (filteredMovieList.isEmpty) {
      subject.sink.addError(601);
    } else {
      subject.sink.add(filteredMovieList);
    }
  }

  dateFormatter(String date) {
    var splitDate = date.split('-');
    String formattedDate = '${splitDate[2]}/${splitDate[1]}/${splitDate[0]}';
    return formattedDate;
  }

  List<String>? genres(List<int> genreIds) {
    List<String> results = [];
    for (int i = 0; i < genreIds.length; i++) {
      switch (genreIds.elementAt(i)) {
        case 12:
          results.add("Adventure");
          break;
        case 14:
          results.add("Fantasy");
          break;
        case 16:
          results.add("Animation");
          break;
        case 18:
          results.add("Drama");
          break;
        case 27:
          results.add("Horror");
          break;
        case 28:
          results.add("Action");
          break;
        case 35:
          results.add("Comedy");
          break;
        case 36:
          results.add("History");
          break;
        case 37:
          results.add("Western");
          break;
        case 53:
          results.add("Thriller");
          break;
        case 80:
          results.add("Crime");
          break;
        case 99:
          results.add("Documentary");
          break;
        case 878:
          results.add("Sci-Fi");
          break;
        case 9648:
          results.add("Mystery");
          break;
        case 10402:
          results.add("Music");
          break;
        case 10749:
          results.add("Romance");
          break;
        case 10751:
          results.add("Family");
          break;
        case 10752:
          results.add("War");
          break;
        case 10770:
          results.add("TV Movie");
      }
    }
    return results;
  }

  void dispose() {
    subject.close();
  }
}
