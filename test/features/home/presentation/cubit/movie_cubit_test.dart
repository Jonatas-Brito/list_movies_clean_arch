import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/usecases/get_popular_movies.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_popular_cubit.dart';

import 'movie_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  MockGetPopularMovies getPopularMovies = MockGetPopularMovies();

  MoviesPopularCubit bloc =
      MoviesPopularCubit(getPopularMovies: getPopularMovies);

  group('GetMoviesPopular is successful', () {
    setUp(() {
      bloc = MoviesPopularCubit(getPopularMovies: getPopularMovies);
      when(getPopularMovies(any)).thenAnswer((_) async => Right(<Movie>[]));
    });
    blocTest<MoviesPopularCubit, MoviePopularState>(
      'should return list movies',
      build: () {
        return bloc;
      },
      act: (bloc) => bloc.getListPopularMovies(),
      expect: () => [
        isA<GetPopularMoviesIsLoading>(),
        isA<GetPopularMoviesIsSuccessful>()
      ],
    );
    test('should return list movies', () async {
      // arrange
      // act
      expect(
        bloc.stream,
        emitsInOrder([
          GetPopularMoviesIsLoading(),
          GetPopularMoviesIsSuccessful(movies: <Movie>[])
        ]),
      );
      // assert
      bloc.getListPopularMovies();
      //assert later        final expected = [          LoadingState(),          LoadedState(projectList: tListProject),        ];        expectLater(favoriteBloc.stream, emitsInOrder(expected));        // act        favoriteBloc.add(GetListFavoriteProjects())
    });
  });

  group(('GetMoviesPopular is failure'), () {
    setUp(() {
      bloc = MoviesPopularCubit(getPopularMovies: getPopularMovies);
      when(getPopularMovies(any))
          .thenAnswer((_) async => Left(ServerFailure()));
    });
    test('should return Failure', () async {
      // act
      expect(
          bloc.stream,
          emitsInOrder([
            GetPopularMoviesIsLoading(),
            GetPopularMoviesIsError(errorMessage: 'errorMessage')
          ]));
      // assert
      bloc.getListPopularMovies();
    });
  });
}
