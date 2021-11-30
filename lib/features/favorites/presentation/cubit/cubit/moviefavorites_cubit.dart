import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../home/domain/entities/movie.dart';
import '../../../domain/usecases/add_movie_to_favorites.dart';
import '../../../domain/usecases/params/favorite_params.dart';
import '../../../domain/usecases/remove_movie_of_favorites.dart';

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
    final failureOrSuccess = await addToFavorites(params);
    _eitherSuccessOrErrorState(failureOrSuccess);
  }

  void removeMovieOfFavorites(Movie movie) async {
    print("REMOVENDO");
    FavoriteParams params = FavoriteParams(movie: movie);
    final failureOrSuccess = await removeOfFavorites(params);
    _eitherSuccessOrErrorState(failureOrSuccess);
  }

  _eitherSuccessOrErrorState(
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
        return AppStrings.CACHED_TO_ADD_FAVORITE_FAILURE;
      case CachedToRemoveFailure:
        return AppStrings.CACHED_TO_REMOVE_FAVORITE_FAILURE;
      default:
    }
    return 'Erro inesperado';
  }
}
