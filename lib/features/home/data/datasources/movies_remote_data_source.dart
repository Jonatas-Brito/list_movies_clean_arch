import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef FutureMovies = Future<List<Movie>>;

abstract class MoviesRemoteDataSource {
  FutureMovies getMoviesPopular(String key);

  FutureMovies getMoviesInTheaters(String key);
}
