import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/cast_people.dart';
import '../entities/movie.dart';

typedef FutureGetMovies = Future<Either<Failure, List<Movie>>>;
typedef FutureGetCast = Future<Either<Failure, List<CastPeople>>>;
typedef FutureYoutubeId = Future<Either<Failure, String>>;

abstract class MoviesRepository {
  MoviesRepository(Object object);

  FutureGetMovies getMoviesPopular(String key);
  FutureGetMovies getMoviesInTheaters(String key);
  FutureYoutubeId getYoutubeId(int id, String key);
  FutureGetMovies getCast(List<Movie> movies, String key);
}
