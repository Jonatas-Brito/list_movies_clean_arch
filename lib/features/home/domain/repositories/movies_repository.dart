import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/movie.dart';

typedef FutureGetMovies = Future<Either<Failure, List<Movie>>>;
typedef FutureYoutubeId = Future<Either<Failure, String>>;

abstract class MoviesRepository {
  MoviesRepository(Object object);

  FutureGetMovies getMoviesPopular(String key);
  FutureGetMovies getMoviesInTheaters(String key);
  FutureYoutubeId getYoutubeId(int id, String key);
}
