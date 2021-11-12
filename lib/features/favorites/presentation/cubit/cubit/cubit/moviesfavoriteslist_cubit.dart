import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/usecases/retrive_movies_favorites.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

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
        emit(GetMoviesFavoritesReturnedListEmpy());
      } else
        emit(GetMoviesFavoritesIsSuccessful(movies: listMovies));
    });
  }
}
