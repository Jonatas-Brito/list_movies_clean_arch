import 'package:dartz/dartz.dart';
import 'package:movies_list/core/failure/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef FutureGetMovies = Future<Either<FailureGetMovies, List<Movie>>>;

abstract class MoviesRepository {
  FutureGetMovies getMoviesPopular(String key);
  FutureGetMovies getMoviesInTheaters(String key);
}
