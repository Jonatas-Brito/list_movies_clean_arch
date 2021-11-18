import 'dart:convert';

import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/features/favorites/data/datasources/favorites_list_local_data_source.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class MoviesFavoriteReposiryImpl implements MoviesFavoriteReposiry {
  final FavoritesListLocalDataSource localFavoritesDataSource;
  const MoviesFavoriteReposiryImpl({required this.localFavoritesDataSource});

  @override
  Future<Either<Failure, Movie>> addMovieToCachedFavorites(Movie movie) async {
    try {
      Movie movieReturned =
          await localFavoritesDataSource.addMovieToCachedFavorites(movie);
      return Right(movieReturned);
    } on CachedException {
      return Left(CachedToAddFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> removeMovieOfFavorites(Movie movie) async {
    try {
      Movie movieReturned =
          await localFavoritesDataSource.removeMovieOfFavorites(movie);
      return Right(movieReturned);
    } on CachedException {
      return Left(CachedToRemoveFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> retriveMoviesFavorites() async {
    List<Movie> moviesFavorites = [];
    try {
      moviesFavorites = await localFavoritesDataSource.retriveFavoritesMovies();
      return Right(moviesFavorites);
    } on CachedException {
      return Left(CachedToRetriveFailure());
    }
  }

  // Future<List<Movie>> _setListFavoriteMovies(Movie movie) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final bool containsKey =
  //       sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);
  //   List<Movie> listFavoriteCache = [];
  //   if (containsKey) {
  //     List dynamicList =
  //         jsonDecode(sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);

  //     dynamicList.forEach((movie) {
  //       listFavoriteCache.add(MovieModel.fromJson(movie));
  //     });
  //   }

  //   return listFavoriteCache;
  // }
}
