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
  Future<Either<Failure, bool>> addMovieToCachedFavorites(Movie movie) async {
    try {
      bool addIsSuccessful =
          await localFavoritesDataSource.addMovieToCachedFavorites(movie);
      return Right(addIsSuccessful);
    } on CachedException {
      return Left(CachedToAddFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> removeMovieOfFavorites(Movie movie) async {
    try {
      bool removeIsSuccessful =
          await localFavoritesDataSource.removeMovieOfFavorites(movie);
      return Right(removeIsSuccessful);
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
}
