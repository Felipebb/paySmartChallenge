import 'package:api_teste/app_module.dart';
import 'package:api_teste/features/upcoming_movies/data/models/upcoming_movies_list_model.dart';
import 'package:api_teste/features/upcoming_movies/domain/usecases/upcoming_movies_use_case.dart';
import 'package:api_teste/features/upcoming_movies/presentation/bloc/upcoming_movies_list_bloc.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUsecase extends Mock implements UpcomingMoviesUseCase {}

void main() async {
  late UpcomingMoviesUseCase mockUsecase;
  late MoviesListBloc bloc;

  setUp(() {
    initModule(
      AppModule(),
      replaceBinds: [Bind<UpcomingMoviesUseCase>((i) => MockUsecase())],
    );
    mockUsecase = Modular.get<UpcomingMoviesUseCase>();
    bloc = MoviesListBloc();
  });

  group('MoviesListBloc tests', () {
    test('getMovies testing', () async {
      when(() => mockUsecase.getUpcomingMovies(any()))
          .thenAnswer((_) async => UpcomingMoviesListModel(null, 0, [], 0, 0));
      bloc.getMovies();

      expect(bloc.auxResponse, isA<UpcomingMoviesListModel>());
      expect(bloc.hasMoreItems, isA<bool>());
      expect(bloc.isLoadingNewsPage, isA<bool>());
    });

    test('dateFormatter testing', () {
      String date = "1998-07-03";
      expect("03/07/1998", bloc.dateFormatter(date));
    });

    test('genres testing', () {
      List<int> genreIds = [12, 16, 35];
      expect(["Adventure", "Animation", "Comedy"], bloc.genres(genreIds));
    });
  });
}
