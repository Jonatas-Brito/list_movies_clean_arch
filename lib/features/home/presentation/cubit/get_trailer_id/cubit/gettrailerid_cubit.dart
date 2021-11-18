import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/error/failure.dart';
import '../../../../../../core/key/tmdb_key.dart';
import '../../../../../../core/strings/app_strings.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_youtube_id.dart';

part 'gettrailerid_state.dart';

class GetTrailerIdCubit extends Cubit<GetTrailerIdState> {
  GetTrailerId getTrailerId;

  GetTrailerIdCubit({required this.getTrailerId})
      : super(GetTrailerIdInitial());

  getIdFromTrailer(Movie movie) async {
    emit(GetTrailerIdIsLoading());
    String key = ApiKey.key;
    final failureOrMovies = await getTrailerId(Params(id: movie.id, key: key));
    _eitherSuccessOrErrorState(failureOrMovies, movie);
  }

  _eitherSuccessOrErrorState(
      Either<Failure, String> failureOrMovies, Movie movie) async {
    failureOrMovies.fold(
        (failure) => emit(
            GetTrailerIdIsError(errorMessage: _setFailureMessage(failure))),
        (trailerId) async {
      movie.trailerId = trailerId;
      print(movie.trailerId = trailerId);
      emit(GetTrailerIdIsSuccessful(movie: movie));
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
