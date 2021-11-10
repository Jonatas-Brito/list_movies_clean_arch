import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';
import 'package:movies_list/features/favorites/domain/usecases/remove_movie_of_favorites.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'remove_movie_of_favorites_test.mocks.dart';

@GenerateMocks([MoviesFavoriteReposiry])
void main() {
  MockMoviesFavoriteReposiry tRepository = MockMoviesFavoriteReposiry();
  RemoveMovieOfFavorites usecase =
      RemoveMovieOfFavorites(favoriteReposiry: tRepository);
  final movie = Movie.empty(id: 1, title: 'Movie Test');

  test('should removed movie of favorites list', () async {
    // arrange
    when(tRepository.removeMovieOfFavorites(any))
        .thenAnswer((_) async => Right(true));
    // act
    final result = await usecase(FavoriteParams(movie: movie));
    // assert
    expect(result.isRight(), true);
    expect(result, Right(true));
  });

  test('should return [CachedFailure] if removed proccess fails', () async {
    // arrange
    when(tRepository.removeMovieOfFavorites(any))
        .thenAnswer((_) async => Left(CachedToRemoveFailure()));
    //act
    final result = await usecase(FavoriteParams(movie: movie));
    //assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => Left(CachedToRemoveFailure), (r) => null),
        Left(CachedToRemoveFailure));
  });
}
