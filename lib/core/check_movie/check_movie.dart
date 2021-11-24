import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/download/domain/usecases/retrive_movies_of_download_list.dart';
import 'package:movies_list/features/favorites/domain/usecases/retrive_movies_favorites.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef FailureOrMovie = Future<Either<Failure, Movie>>;
typedef FailureOrMovies = Future<Either<Failure, List<Movie>>>;

abstract class CheckMovie {
  FailureOrMovie checkMovie(Movie movie);
}

class CheckMovieImpl implements CheckMovie {
  final RetriveMoviesFavorites retriveMoviesFavorites;
  final RetriveMoviesForDownload retriveMoviesForDownload;
  const CheckMovieImpl({
    required this.retriveMoviesFavorites,
    required this.retriveMoviesForDownload,
  });
  @override
  FailureOrMovie checkMovie(Movie movie) async {
    Movie movie = Movie.empty();
    try {
      final failureOrSuccessFavorites = await retriveMoviesFavorite();

      final failureOrSuccessDownload = await retriveMoviesDownload();

      bool downloadNotRigh = failureOrSuccessDownload is Left;
      bool favoriteNotRigh = failureOrSuccessFavorites is Left;
      if (downloadNotRigh && favoriteNotRigh) {}

      return Future.value(Right(movie));
    } catch (e) {
      throw Left(ErrorCheckMovie());
    }
  }

  Movie verifyIfMovieIsFavorite(
      List<Movie> favoriteMovies, Movie selectedMovie) {
    Movie movieSelected = Movie.empty();

    movieSelected = selectedMovie;
    favoriteMovies.forEach((movieFavorite) {
      bool equalsId = movieFavorite.id == movieSelected.id;
      if (equalsId) {
        movieSelected = movieFavorite;
      }
    });

    return movieSelected;
  }

  Movie verifyIfMovieHasDownload(
      List<Movie> downloadMovies, Movie selectedMovie) {
    Movie movieSelected = Movie.empty();

    movieSelected = selectedMovie;
    downloadMovies.forEach((movieInDownload) {
      bool equalsId = movieInDownload.id == movieSelected.id;
      if (equalsId) {
        movieSelected = movieInDownload;
      }
    });

    return movieSelected;
  }

  FailureOrMovies retriveMoviesDownload() async {
    NoParams params = NoParams();

    final failureOrSuccessDownload = retriveMoviesForDownload(params);

    return failureOrSuccessDownload;
  }

  FailureOrMovies retriveMoviesFavorite() async {
    NoParams params = NoParams();

    final failureOrSuccessFavorite = retriveMoviesFavorites(params);

    return failureOrSuccessFavorite;
  }

  failureOrSuccess(failureOrSuccess) {}
}
