import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/key/tmdb_key.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/usecases/get_popular_movies.dart';

part 'movies_popular_state.dart';

// UnconnectedDevice
const String SERVER_FAILURE_MESSAGE = 'Houve um problema no servidor';

const String NETWORK_FAILURE_MESSAGE =
    'É necessário se connectar a internet para listar os filmes';

class MoviesPopularCubit extends Cubit<MoviePopularState> {
  final GetPopularMovies getPopularMovies;

  MoviesPopularCubit({required this.getPopularMovies})
      : super(PopularMoviesIsIdle());

  void getListPopularMovies() async {
    emit(GetPopularMoviesIsLoading());
    String key = ApiKey.key;
    final faiulureOrMovies = await getPopularMovies.call(Params(key: key));

    _eitherLoadedOrErrorState(faiulureOrMovies);
  }

  _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(
            GetPopularMoviesIsError(errorMessage: _mapFailureMessage(failure))),
        (listMovies) => emit(GetPopularMoviesIsSuccessful(movies: listMovies)));
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case UnconnectedDevice:
        return NETWORK_FAILURE_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
    }
    return 'Erro inesperado';
  }
}
