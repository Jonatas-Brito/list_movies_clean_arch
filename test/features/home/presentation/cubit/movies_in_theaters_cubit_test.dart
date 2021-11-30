// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movies_list/core/error/failure.dart';
// import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/usecases/get_movies_in_theaters.dart';
// import 'package:movies_list/features/home/presentation/cubit/movies_in_theaters/movies_in_theaters_cubit.dart';

// import 'movies_in_theaters_cubit_test.mocks.dart';

// @GenerateMocks([GetMoviesInTheaters])
void main() {
  // MockGetMoviesInTheaters getMoviesInTheaters = MockGetMoviesInTheaters();

  // MoviesInTheatersCubit bloc =
  //     MoviesInTheatersCubit(getMoviesInTheaters: getMoviesInTheaters);

  // group('GetMoviesInTheaters is successful', () {
  //   setUp(() {
  //     bloc = MoviesInTheatersCubit(getMoviesInTheaters: getMoviesInTheaters);
  //     when(getMoviesInTheaters(any)).thenAnswer((_) async => Right(<Movie>[]));
  //   });
  //   blocTest<MoviesInTheatersCubit, MoviesInTheatersState>(
  //     '[BlocTest] should return list movies',
  //     build: () {
  //       return bloc;
  //     },
  //     act: (bloc) => bloc.getListMoviesInTheaters(),
  //     wait: Duration(seconds: 3),
  //     expect: () => [
  //       isA<GetMoviesInTheatersIsLoading>(),
  //       isA<GetMoviesInTheatersIsSuccessful>()
  //     ],
  //   );
  //   test('should return list movies', () async {
  //     // arrange
  //     // act

  //     expect(
  //       bloc.stream,
  //       emitsInOrder([
  //         GetMoviesInTheatersIsLoading(),
  //         GetMoviesInTheatersIsSuccessful(movies: <Movie>[])
  //       ]),
  //     );

  //     bloc.getListMoviesInTheaters();

  //     // assert
  //     //assert later        final expected = [          LoadingState(),          LoadedState(projectList: tListProject),        ];        expectLater(favoriteBloc.stream, emitsInOrder(expected));        // act        favoriteBloc.add(GetListFavoriteProjects())
  //   });
  // });

  // group(('GetMoviesPopular is failure'), () {
  //   setUp(() {
  //     bloc = MoviesInTheatersCubit(getMoviesInTheaters: getMoviesInTheaters);
  //     when(getMoviesInTheaters(any))
  //         .thenAnswer((_) async => Left(ServerFailure()));
  //   });
  //   test('should return Failure', () async {
  //     // act
  //     expect(
  //         bloc.stream,
  //         emitsInOrder([
  //           GetMoviesInTheatersIsLoading(),
  //           GetMoviesInTheatersIsError(errorMessage: 'errorMessage')
  //         ]));
  //     // assert
  //     bloc.getListMoviesInTheaters();
  //   });
  // });
}
