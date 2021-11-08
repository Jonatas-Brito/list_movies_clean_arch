// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:movies_list/core/error/failure.dart';
// import 'package:movies_list/features/home/domain/entities/movie.dart';
// import 'package:movies_list/features/home/domain/usecases/get_popular_movies.dart';
// import 'package:movies_list/features/home/presentation/cubit/movie_cubit.dart';

// class MockGetPopularMovies extends Mock implements GetPopularMovies {}

// void main() {
//   MockGetPopularMovies getPopularMovies = MockGetPopularMovies();

//   MoviePopularCubit bloc =
//       MoviePopularCubit(getPopularMovies: getPopularMovies);

//   group('GetMoviesPopular', () {
//     blocTest<MoviePopularCubit, MoviePopularState>(
//       'should return list movies',
//       build: () => bloc,
//       act: (bloc) => bloc.getListPopularMovies(),
//       expect: () => [
//         GetPopularMoviesIsLoading(),
//       ],
//     );

//     test('shoul emit [Error] when returned SERVERFAILURE', () async {
//       // arrange
//       when(() => getPopularMovies.call(Params(key: 'key')))
//           .thenAnswer((invocation) async => Right(<Movie>[]));
//       // act
//       bloc.getListPopularMovies();
//       await untilCalled(() => getPopularMovies.call(Params(key: 'key')));
//       // // assert
//       // expectLater(
//       //     bloc.state,
//       //     emitsInOrder(
//       //         [GetPopularMoviesIsError(errorMessage: SERVER_FAILURE_MESSAGE)]));
//     });
//   });
// }
