import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/strings/app_strings.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/usecases/usecases.dart';
import '../../../../../home/domain/entities/movie.dart';
import '../../../../domain/usecases/retrive_movies_favorites.dart';

part 'moviesfavoriteslist_state.dart';

const String CACHED_RETRIVE_IS_FAIULURE =
    'Ocorreu um erro ao listar filmes favoritos';

class MoviesFavoritesListCubit extends Cubit<MoviesFavoritesListState> {
  final RetriveMoviesFavorites retriveMovies;
  MoviesFavoritesListCubit({required this.retriveMovies})
      : super(MoviesfavoriteslistInitial());

  getListFavorites() async {
    emit(GetMoviesFavoritesIsLoading());
    NoParams params = NoParams();
    final failureOrMovies = await retriveMovies.call(params);
    await Future.delayed(Duration(milliseconds: 100));
    _eitherLoadedOrErrorState(failureOrMovies);
  }

  _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(GetMoviesFavoritesIsError(
            errorMessage: CACHED_RETRIVE_IS_FAIULURE)), (listMovies) {
      if (listMovies.isEmpty) {
        emit(GetMoviesFavoritesReturnedListEmpy(
            message: AppStrings.thereNoFavorites));
      } else {
        print(listMovies.length);
        emit(GetMoviesFavoritesIsSuccessful(movies: listMovies));
      }
    });
  }
}
