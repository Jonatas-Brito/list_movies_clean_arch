import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/repositories/movies_repository.dart';
import 'package:movies_list/features/home/domain/usecases/get_popular_movies.dart';

import 'get_movies_in_theaters_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  GetPopularMovies tUsecase;
  MockMoviesRepository tRepository;

  tRepository = MockMoviesRepository();
  tUsecase = GetPopularMovies(tRepository);

  test('get list of popular movies', () async {
    //arrange
    String key = 'key';
    when(tRepository.getMoviesPopular(key))
        .thenAnswer((_) async => Right(<Movie>[]));
    //act
    final result = await tUsecase(Params(key: key));
    //assert
    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<Movie>>());
  });

  test('get list of popular movies failed', () async {
    //arrange
    String key = 'key';
    when(tRepository.getMoviesPopular(key))
        .thenAnswer((_) async => Left(ServerFailure()));
    //act
    final result = await tUsecase(Params(key: key));
    //assert
    expect(result.isRight(), false);
    expect(result.fold(id, id), isA<ServerFailure>());
  });
}
