part of 'moviesfavoriteslist_cubit.dart';

abstract class MoviesFavoritesListState extends Equatable {
  const MoviesFavoritesListState();

  @override
  List<Object> get props => [];
}

class MoviesfavoriteslistInitial extends MoviesFavoritesListState {}

class GetMoviesFavoritesIsSuccessful extends MoviesFavoritesListState {
  final List<Movie> movies;
  const GetMoviesFavoritesIsSuccessful({required this.movies}) : super();
}

class GetMoviesFavoritesIsLoading extends MoviesFavoritesListState {
  const GetMoviesFavoritesIsLoading() : super();
}

class GetMoviesFavoritesIsError extends MoviesFavoritesListState {
  final String errorMessage;
  const GetMoviesFavoritesIsError({required this.errorMessage}) : super();
}
