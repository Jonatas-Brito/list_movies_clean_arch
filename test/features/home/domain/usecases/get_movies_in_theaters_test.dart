import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_list/core/failure/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/repositories/movies_repository.dart';
import 'package:movies_list/features/home/domain/usecases/get_movies_in_theaters.dart';

class GetMoviesRepositoryMock extends Mock implements MoviesRepository {}

void main() {
  final tRepository = GetMoviesRepositoryMock();
  final tUsecase = GetMoviesInTeathers(tRepository);

  test('get list of movies in theater ', () async {
    //arrange
    String key = 'key';
    when(() => tRepository.getMoviesInTheaters(key))
        .thenAnswer((_) async => Right(<Movie>[]));
    //act
    final result = await tUsecase(Params(key: key));
    //assert

    expect(result.isRight(), true);
    expect(result.fold(id, id), isA<List<Movie>>());
  });

  test('get list of movies in theater failed', () async {
    //arrange
    String key = 'key';
    when(() => tRepository.getMoviesInTheaters(key))
        .thenAnswer((_) async => Left(FailureGetMovies()));
    //act
    final result = await tUsecase(Params(key: key));
    //assert

    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<FailureGetMovies>());
  });
}
