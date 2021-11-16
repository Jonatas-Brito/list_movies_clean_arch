part of 'movies_in_theaters_cubit.dart';

abstract class MoviesInTheatersState extends Equatable {
  const MoviesInTheatersState();

  @override
  List<Object> get props => [];
}

class MoviesInTheatersInitial extends MoviesInTheatersState {}

class GetMoviesInTheatersIsSuccessful extends MoviesInTheatersState {
  final List<Movie> movies;
  const GetMoviesInTheatersIsSuccessful({required this.movies}) : super();
}

class GetMoviesInTheatersIsLoading extends MoviesInTheatersState {
  const GetMoviesInTheatersIsLoading() : super();
}

class GetMoviesInTheatersIsError extends MoviesInTheatersState {
  final String errorMessage;
  const GetMoviesInTheatersIsError({required this.errorMessage}) : super();
}
