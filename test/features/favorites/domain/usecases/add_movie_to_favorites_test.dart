import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/favorites/domain/usecases/add_movie_to_favorites.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'add_movie_to_favorites_test.mocks.dart';

@GenerateMocks([MoviesFavoriteReposiry])
void main() {
  MockMoviesFavoriteReposiry tRepository = MockMoviesFavoriteReposiry();
  AddMovieToFavorites useCase = AddMovieToFavorites(tRepository);
  final movie = Movie.empty(id: 1, title: 'Movie Test');

  test('should return movie if successful', () async {
    // arrange
    when(tRepository.addMovieToCachedFavorites(any))
        .thenAnswer((_) async => Right(true));
    // act
    final result = await useCase(FavoriteParams(movie: movie));
    // assert
    expect(result, Right(true));
  });

  test('should return [CachedFailure] if the chached process fails', () async {
    // arrange
    when(tRepository.addMovieToCachedFavorites(any))
        .thenAnswer((_) async => Left(CachedToAddFailure()));
    // act
    final result = await useCase(FavoriteParams(movie: movie));
    // assert
    verify(useCase(FavoriteParams(movie: movie)));
    expect(result.isLeft(), true);
    expect(result.fold((l) => Left(CachedToAddFailure), (r) => null),
        Left(CachedToAddFailure));
  });
}
