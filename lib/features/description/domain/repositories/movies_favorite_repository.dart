import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
// / Get the previously [List<Movie>] cached favorite movies list
//   /
//   / Throws [CacheException] if no cached data is present.

abstract class MoviesFavoriteReposiry {
  Future<List<Movie>> getListMoviesFavorite();
  Future<Either<Failure, void>> addMovieToCachedFavorite(Movie movie);
  Future<Movie> retriveMovieFavorite(Movie movie);
}
