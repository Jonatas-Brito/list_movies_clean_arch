import 'package:movies_list/features/home/domain/entities/movie.dart';

Movie checkMovie(
    {required Movie selectedMovie, required List<Movie> favoriteMovies}) {
  Movie movieSelected = Movie.empty();
  movieSelected = selectedMovie;
  favoriteMovies.forEach((movie) {
    bool equalsId = movie.id == movieSelected.id;
    if (equalsId) {
      movieSelected = movie;
    }
  });

  return movieSelected;
}
