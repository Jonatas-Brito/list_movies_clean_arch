import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(
      String text, List<Movie> movies);
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<Either<Failure, List<Movie>>> searchMovies(
      String text, List<Movie> movies) {
    List<Movie> listMovies = [];
    try {
      movies.forEach((movie) {
        bool contain = movie.title.toLowerCase().contains(text.toLowerCase());
        if (contain) {
          listMovies.add(movie);
        }
      });

      return Future.value(Right(listMovies));
    } catch (e) {
      throw Future.value(Left(SearchFailure()));
    }
  }
}
