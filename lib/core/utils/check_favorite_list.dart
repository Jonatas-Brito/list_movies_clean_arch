import 'package:movies_list/features/home/domain/entities/movie.dart';

Movie checkMovie(
    {required Movie selectedMovie, required List<Movie> favoriteMovies}) {
  Movie movieSelected = Movie.empty();
  movieSelected = selectedMovie;
  favoriteMovies.forEach((movieFavorite) {
    bool equalsId = movieFavorite.id == movieSelected.id;
    if (equalsId) {
      movieSelected = movieFavorite;
    }
  });

  print("Is favorite | HomePage: ${movieSelected.isFavorite}");

  return movieSelected;
}
