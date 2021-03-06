import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/key/tmdb_key.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_movies_in_theaters.dart';

part 'movies_in_theaters_state.dart';

class MoviesInTheatersCubit extends Cubit<MoviesInTheatersState> {
  final GetMoviesInTheaters getMoviesInTheaters;

  MoviesInTheatersCubit({required this.getMoviesInTheaters})
      : super(MoviesInTheatersInitial());

  void getListMoviesInTheaters() async {
    emit(GetMoviesInTheatersIsLoading());
    String key = ApiKey.key;
    final faiulureOrMovies = await getMoviesInTheaters.call(Params(key: key));
    _eitherSuccessOrErrorState(faiulureOrMovies);
  }

  _eitherSuccessOrErrorState(
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
        return AppStrings.NETWORK_FAILURE_MESSAGE;
      case ServerFailure:
        return AppStrings.SERVER_FAILURE_MESSAGE;
      default:
    }
    return 'Erro inesperado';
  }
}
