import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/strings/app_strings.dart';
import 'package:movies_list/features/favorites/domain/usecases/add_movie_to_favorites.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';
import 'package:movies_list/features/favorites/domain/usecases/remove_movie_of_favorites.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

part 'moviefavorites_state.dart';

class ManagerFavoritesMoviesCubit extends Cubit<ManagerFavoritesMoviesState> {
  final AddMovieToFavorites addToFavorites;
  final RemoveMovieOfFavorites removeOfFavorites;
  ManagerFavoritesMoviesCubit(
      {required this.addToFavorites, required this.removeOfFavorites})
      : super(ManagerFavoritesMoviesInitial());

  void addMovieToFavorites(Movie movie) async {
    print("ADICIONANDO");
    FavoriteParams params = FavoriteParams(movie: movie);
    final failureOrSuccess = await addToFavorites.call(params);
    _eitherSuccussOrErrorState(failureOrSuccess);
  }

  void removeMovieOfFavorites(Movie movie) async {
    print("REMOVENDO");
    FavoriteParams params = FavoriteParams(movie: movie);
    final failureOrSuccess = await removeOfFavorites.call(params);
    _eitherSuccussOrErrorState(failureOrSuccess);
  }

  _eitherSuccussOrErrorState(
    Either<Failure, Movie> failureOrSuccess,
  ) async {
    failureOrSuccess.fold(
        (failure) => emit(CachedToFavoritesFailure(
            errorMessage: _setFailureMessage(failure))), (movie) async {
      emit(CachedToFavoritesSuccess(movie: movie));
      await Future.delayed(Duration(milliseconds: 100));
      emit(ManagerFavoritesMoviesInitial());
    });
  }

  String _setFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CachedToAddFailure:
        return AppStrings.CACHED_TO_ADD_FAILURE;
      case CachedToRemoveFailure:
        return AppStrings.CACHED_TO_REMOVE_FAILURE;
      default:
    }
    return 'Erro inesperado';
  }
}
