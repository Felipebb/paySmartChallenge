import 'package:api_teste/features/upcoming_movies/data/models/upcoming_movies_list_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, Object> response;
  late UpcomingMoviesListModel upcomingMoviesListModel;
  setUp(() async {
    response = {
      "dates": {"maximum": "2021-12-22", "minimum": "2021-12-01"},
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/70nxSw3mFBsGmtkvcs91PbjerwD.jpg",
          "genre_ids": [878, 28, 12],
          "id": 580489,
          "original_language": "en",
          "original_title": "Venom: Let There Be Carnage",
          "overview":
              "After finding a host body in investigative reporter Eddie Brock, the alien symbiote must face a new enemy, Carnage, the alter ego of serial killer Cletus Kasady.",
          "popularity": 8117.008,
          "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
          "release_date": "2021-09-30",
          "title": "Venom: Let There Be Carnage",
          "video": false,
          "vote_average": 7.2,
          "vote_count": 2758
        },
      ],
      "total_pages": 26,
      "total_results": 508
    };
  });

  group('PopularMoviesListModel Json Parser', () {
    test('[ PopularMoviesListModel ] should be parsed', () {
      upcomingMoviesListModel = UpcomingMoviesListModel.fromJson(response);
      expect(upcomingMoviesListModel, equals(isNotNull));
    });
    test('page should be [1] ', () {
      expect(upcomingMoviesListModel.page, 1);
    });

    test('total_pages should be [26] ', () {
      expect(upcomingMoviesListModel.totalPages, 26);
    });

    test('total_results should be [508] ', () {
      expect(upcomingMoviesListModel.totalResults, 508);
    });

    test('dates maximum should be [2021-12-22] ', () {
      expect(upcomingMoviesListModel.dates!.maximum, '2021-12-22');
    });

    test('results size should be 1 ', () {
      expect(upcomingMoviesListModel.results!.length, 1);
    });

    test('results id should be [580489] ', () {
      expect(upcomingMoviesListModel.results!.elementAt(0).id, 580489);
    });
  });
}
