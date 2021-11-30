import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

/// Get the previously [List<Movie>] cached movies list for download
/// Add [Movie] to movies list for download
/// Remove [Movie] to movies list for download
///
/// Throws [CacheException] if no cached data is present.

abstract class MoviesDownloadRepository {
  Future<Either<Failure, List<Movie>>> retriveMoviesForDownload();
  Future<Either<Failure, Movie>> addMoviesForDownload(Movie movie);
  Future<Either<Failure, Movie>> removeMoviesForDownload(Movie movie);
}
