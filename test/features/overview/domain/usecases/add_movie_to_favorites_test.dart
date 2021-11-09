import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/description/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/description/domain/usecases/add_movie_to_favorites.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'add_movie_to_favorites_test.mocks.dart';

@GenerateMocks([MoviesFavoriteReposiry])
void main() {
  MockMoviesFavoriteReposiry tRepository = MockMoviesFavoriteReposiry();
  AddMovieToFavorite useCase = AddMovieToFavorite(tRepository);
  final movie = Movie.empty(id: 1, title: 'Movie Test');

  test('should return movie ifsuccessful', () async {
    // arrange
    when(tRepository.addMovieToCachedFavorite(any))
        .thenAnswer((_) async => Right(movie));
    // act
    final result = await useCase(FavoriteParams(movie: movie));
    // assert
    expect(result, Right(movie));
  });

  test('should return [CachedFailure] if the chached process fails', () async {
    // arrange
    when(tRepository.addMovieToCachedFavorite(any))
        .thenAnswer((_) async => Left(CachedFailure()));
    // act
    final result = await useCase(FavoriteParams(movie: movie));
    // assert
    verify(useCase(FavoriteParams(movie: movie)));
    expect(result.isLeft(), true);
    expect(result.fold((l) => Left(CachedFailure), (r) => null),
        Left(CachedFailure));
  });
}
