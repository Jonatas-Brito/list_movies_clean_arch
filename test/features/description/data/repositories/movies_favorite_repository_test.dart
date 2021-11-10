import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/favorites/data/datasources/favorites_list_local_data_source.dart';
import 'package:movies_list/features/favorites/data/repositories/movies_favorite_repository_impl.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'movies_favorite_repository_test.mocks.dart';

@GenerateMocks([FavoritesListLocalDataSourceImpl])
void main() {
  MockFavoritesListLocalDataSourceImpl localFavoritesDataSource =
      MockFavoritesListLocalDataSourceImpl();

  MoviesFavoriteReposiryImpl favoriteReposiryImpl = MoviesFavoriteReposiryImpl(
      localFavoritesDataSource: localFavoritesDataSource);

  final movie = Movie.empty(id: 1, title: "Test Movie");
  final listMovie = <Movie>[movie];

  group('check the [addMovieToCachedFavorites] function |', () {
    test('should return [Movie] if cached is successful', () async {
      // arrange
      when(localFavoritesDataSource.addMovieToCachedFavorites(any))
          .thenAnswer((_) async => movie);
      // act
      final result =
          await favoriteReposiryImpl.addMovieToCachedFavorites(movie);
      // assert
      verify(localFavoritesDataSource.addMovieToCachedFavorites(movie));
      expect(result, Right(movie));
    });

    test('should return [CachedFailure] if the chached process fails ',
        () async {
      // arrange
      when(localFavoritesDataSource.addMovieToCachedFavorites(any))
          .thenAnswer((_) async => throw CachedException());
      // act
      final result =
          await favoriteReposiryImpl.addMovieToCachedFavorites(movie);
      // assert
      verify(localFavoritesDataSource.addMovieToCachedFavorites(movie));
      expect(result.fold(id, id), isA<CachedFailure>());
      expect(result.fold((l) => Left(CachedFailure), (r) => null),
          Left(CachedFailure));
    });
  });

  ///
  ///
  ///
  ///
  ///
  ///

  group('check the [removeMovieOfFavorites] function |', () {
    test('should return [Movie] if cached is successful', () async {
      // arrange
      when(localFavoritesDataSource.removeMovieOfFavorites(any))
          .thenAnswer((_) async => true);
      // act
      final result = await favoriteReposiryImpl.removeMovieOfFavorites(movie);
      // assert
      verify(localFavoritesDataSource.removeMovieOfFavorites(movie));
      expect(result, Right(movie));
    });

    test('should return [CachedFailure] if the chached process fails ',
        () async {
      // arrange
      when(localFavoritesDataSource.removeMovieOfFavorites(any))
          .thenAnswer((_) async => throw CachedException());
      // act
      final result = await favoriteReposiryImpl.removeMovieOfFavorites(movie);
      // assert
      verify(localFavoritesDataSource.removeMovieOfFavorites(movie));
      expect(result.fold(id, id), isA<CachedFailure>());
      expect(result.fold((l) => Left(CachedFailure), (r) => null),
          Left(CachedFailure));
    });
  });

  ///
  ///
  ///
  ///
  ///
  ///

  group('check the [retriveFavoritesMovies] function |', () {
    test(
        'should return [List<Movie>] if caching is successful and if there is a cached list',
        () async {
      // arrange
      when(localFavoritesDataSource.retriveFavoritesMovies())
          .thenAnswer((_) async => listMovie);
      // act
      final result = await favoriteReposiryImpl.retriveMoviesFavorites();
      // assert
      expect(result.fold(id, id), listMovie);
      expect(result, Right(listMovie));
    });

    test('should return [CachedFailure] if the chached process fails ',
        () async {
      // arrange
      when(localFavoritesDataSource.retriveFavoritesMovies())
          .thenAnswer((_) async => throw CachedException());
      // act
      final result = await favoriteReposiryImpl.retriveMoviesFavorites();
      // assert
      expect(result.fold(id, id), isA<CachedFailure>());
      expect(result.fold((l) => Left(CachedFailure), (r) => null),
          Left(CachedFailure));
    });
  });
}
