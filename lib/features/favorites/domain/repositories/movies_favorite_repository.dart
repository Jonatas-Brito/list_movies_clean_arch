import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/movie.dart';

/// Get the previously [List<Movie>] cached favorite movies list
/// Add [Movie] to movies list favorite
/// Remove [Movie] to movies list favorite
///
/// Throws [CacheException] if no cached data is present.

abstract class MoviesFavoriteReposiry {
  Future<Either<Failure, List<Movie>>> retriveMoviesFavorites();
  Future<Either<Failure, Movie>> addMovieToCachedFavorites(Movie movie);
  Future<Either<Failure, Movie>> removeMovieOfFavorites(Movie movie);
}
