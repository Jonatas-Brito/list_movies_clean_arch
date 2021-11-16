import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/key/tmdb_key.dart';
import 'package:movies_list/features/home/data/repositories/movies_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/usecases/get_movies_in_theaters.dart';

part 'movies_in_theaters_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Houve um problema no servidor';

const String NETWORK_FAILURE_MESSAGE =
    'É necessário se connectar a internet para listar os filmes';

class MoviesInTheatersCubit extends Cubit<MoviesInTheatersState> {
  final GetMoviesInTheaters getMoviesInTheaters;

  MoviesInTheatersCubit({required this.getMoviesInTheaters})
      : super(MoviesInTheatersInitial());

  void getListMoviesInTheaters() async {
    emit(GetMoviesInTheatersIsLoading());
    String key = ApiKey.key;
    final faiulureOrMovies = await getMoviesInTheaters.call(Params(key: key));
    _eitherLoadedOrErrorState(faiulureOrMovies);
  }

  _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(GetMoviesInTheatersIsError(
            errorMessage: _setFailureMessage(failure))), (listMovies) async {
      await Future.delayed(Duration(seconds: 3));
      emit(GetMoviesInTheatersIsSuccessful(movies: listMovies));
    });
  }

  String _setFailureMessage(Failure failure) {
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
