part of 'movies_popular_cubit.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();

  @override
  List<Object> get props => [];
}

class PopularMoviesIsIdle extends MoviePopularState {
  const PopularMoviesIsIdle() : super();
}

class GetPopularMoviesIsSuccessful extends MoviePopularState {
  final List<Movie> movies;
  const GetPopularMoviesIsSuccessful({required this.movies}) : super();
}

class GetPopularMoviesIsLoading extends MoviePopularState {
  const GetPopularMoviesIsLoading() : super();
}

class GetPopularMoviesIsError extends MoviePopularState {
  final String errorMessage;
  const GetPopularMoviesIsError({required this.errorMessage}) : super();
}
