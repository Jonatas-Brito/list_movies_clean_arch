import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/strings/app_strings.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../../home/domain/entities/movie.dart';
import '../../../../domain/usecases/retrive_movies_favorites.dart';

part 'moviesfavoriteslist_state.dart';

class MoviesFavoritesListCubit extends Cubit<MoviesFavoritesListState> {
  final RetriveMoviesFavorites retriveMovies;
  MoviesFavoritesListCubit({required this.retriveMovies})
      : super(MoviesfavoriteslistInitial());

  getListFavorites() async {
    emit(GetMoviesFavoritesIsLoading());
    NoParams params = NoParams();
    final failureOrMovies = await retriveMovies.call(params);
    await Future.delayed(Duration(milliseconds: 100));
    _eitherSuccessOrErrorState(failureOrMovies);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(GetMoviesFavoritesIsError(
            errorMessage: AppStrings.CACHED_RETRIVE_FAVORITE_IS_FAILURE)),
        (listMovies) {
      if (listMovies.isEmpty) {
        emit(GetMoviesFavoritesReturnedListEmpy(
            message: AppStrings.thereNoFavorites));
      } else {
        emit(GetMoviesFavoritesIsSuccessful(movies: listMovies));
      }
    });
  }
}
