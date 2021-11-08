import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/movie.dart';

typedef FutureGetMovies = Future<Either<Failure, List<Movie>>>;

abstract class MoviesRepository {
  MoviesRepository(Object object);

  FutureGetMovies getMoviesPopular(String key);
  FutureGetMovies getMoviesInTheaters(String key);
}
