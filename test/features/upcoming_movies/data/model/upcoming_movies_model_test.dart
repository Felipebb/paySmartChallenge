import 'package:api_teste/features/upcoming_movies/data/models/upcoming_movies_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, Object> response;
  late UpcomingMoviesModel upcomingMoviesModel;

  setUp(() async {
    response = {
      "adult": false,
      "backdrop_path": "/70nxSw3mFBsGmtkvcs91PbjerwD.jpg",
      "genre_ids": [878, 28, 12],
      "id": 580489,
      "original_language": "en",
      "original_title": "Venom: Let There Be Carnage",
      "overview": "After finding a host..",
      "popularity": 8117.008,
      "poster_path": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
      "release_date": "2021-09-30",
      "title": "Venom: Let There Be Carnage",
      "video": false,
      "vote_average": 7.2,
      "vote_count": 2758
    };
  });

  group('PopularMoviesListModel Json Parser', () {
    test('[ PopularMoviesListModel ] should be parsed', () {
      upcomingMoviesModel = UpcomingMoviesModel.fromJson(response);
      expect(upcomingMoviesModel, equals(isNotNull));
    });

    test('adult should be [false] ', () {
      expect(upcomingMoviesModel.adult, false);
    });
    test('backdrop_path should be [/70nxSw3mFBsGmtkvcs91PbjerwD.jpg] ', () {
      expect(
          upcomingMoviesModel.backdropPath, "/70nxSw3mFBsGmtkvcs91PbjerwD.jpg");
    });
    test('id should be [580489] ', () {
      expect(upcomingMoviesModel.id, 580489);
    });
    test('original_language should be [en] ', () {
      expect(upcomingMoviesModel.originalLanguage, "en");
    });
    test('original_title should be [Venom: Let There Be Carnage] ', () {
      expect(upcomingMoviesModel.originalTitle, "Venom: Let There Be Carnage");
    });
    test('overview should be [After finding a host..] ', () {
      expect(upcomingMoviesModel.overview, "After finding a host..");
    });
    test('popularity should be [8117.008] ', () {
      expect(upcomingMoviesModel.popularity, 8117.008);
    });
    test('poster_path should be [/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg] ', () {
      expect(
          upcomingMoviesModel.posterPath, "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg");
    });
    test('release_date should be [2021-09-30] ', () {
      expect(upcomingMoviesModel.releaseDate, "2021-09-30");
    });
    test('title should be [Venom: Let There Be Carnage] ', () {
      expect(upcomingMoviesModel.title, "Venom: Let There Be Carnage");
    });
    test('video should be [false] ', () {
      expect(upcomingMoviesModel.video, false);
    });
    test('vote_average should be [7.2] ', () {
      expect(upcomingMoviesModel.voteAverage, 7.2);
    });
    test('vote_count should be [2758] ', () {
      expect(upcomingMoviesModel.voteCount, 2758);
    });
  });
}
