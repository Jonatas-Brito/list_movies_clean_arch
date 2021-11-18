part of 'search_movie_cubit.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieIsLoading extends SearchMovieState {}

class SearchMovieIsSuccess extends SearchMovieState {
  final List<Movie> movies;
  const SearchMovieIsSuccess({required this.movies});
}

class SearchMovieIsError extends SearchMovieState {
  final String errorMessage;
  const SearchMovieIsError({required this.errorMessage});
}
