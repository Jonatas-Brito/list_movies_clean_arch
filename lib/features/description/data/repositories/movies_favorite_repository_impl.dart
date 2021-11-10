import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/features/description/data/datasources/favorites_list_local_data_source.dart';
import 'package:movies_list/features/description/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class MoviesFavoriteReposiryImpl implements MoviesFavoriteReposiry {
  final FavoritesListLocalDataSource localFavoritesDataSource;
  const MoviesFavoriteReposiryImpl({required this.localFavoritesDataSource});

  @override
  Future<Either<Failure, Movie>> addMovieToCachedFavorites(Movie movie) async {
    try {
      await localFavoritesDataSource.addMovieToCachedFavorites(movie);
      return Right(movie);
    } on CachedException {
      return Left(CachedFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> removeMovieOfFavorites(Movie movie) async {
    try {
      await localFavoritesDataSource.removeMovieOfFavorites(movie);
      return Right(movie);
    } on CachedException {
      return Left(CachedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> retriveMoviesFavorites() async {
    List<Movie> moviesFavorites = [];
    try {
      moviesFavorites = await localFavoritesDataSource.retriveFavoritesMovies();
      return Right(moviesFavorites);
    } on CachedException {
      return Left(CachedFailure());
    }
  }
}
