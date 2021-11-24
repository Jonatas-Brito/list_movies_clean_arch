import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/key/tmdb_key.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_cast.dart';

part 'get_cast_people_state.dart';

class GetCastPeopleCubit extends Cubit<GetCastPeopleState> {
  String key = ApiKey.key;
  GetCastPeople getCastPeople;
  GetCastPeopleCubit({required this.getCastPeople})
      : super(GetCastPeopleInitial());

  getPeopleCast(List<Movie> movies) async {
    emit(GetCastPeopleIsLoading());
    final failureOrListCast =
        await getCastPeople(Params(movies: movies, key: key));
    _eitherSuccessOrErrorState(failureOrListCast);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, List<Movie>> failureOrListCast,
  ) async {
    failureOrListCast.fold(
        (failure) => emit(
            GetCastPeopleIsError(errorMessage: _setFailureMessage(failure))),
        (listCast) async {
      print("Cast: $listCast");
      emit(GetCastPeopleIsSuccessful(listCast: listCast));
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
