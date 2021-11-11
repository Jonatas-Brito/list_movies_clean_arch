part of 'moviefavorites_cubit.dart';

abstract class ManagerFavoritesMoviesState extends Equatable {
  const ManagerFavoritesMoviesState();

  @override
  List<Object> get props => [];
}

class ManagerFavoritesMoviesInitial extends ManagerFavoritesMoviesState {}

class CachedToFavoritesSuccess extends ManagerFavoritesMoviesState {
  final Movie movie;
  const CachedToFavoritesSuccess({required this.movie});
}

class CachedToFavoritesFailure extends ManagerFavoritesMoviesState {
  final String errorMessage;
  const CachedToFavoritesFailure({required this.errorMessage});
}
