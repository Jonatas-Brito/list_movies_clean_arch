import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/key/tmdb_key.dart';
import 'package:movies_list/core/strings/app_strings.dart';
import 'package:movies_list/features/home/domain/entities/cast_people.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/usecases/get_cast.dart';

part 'get_cast_people_state.dart';

class GetCastPeopleCubit extends Cubit<GetCastPeopleState> {
  String key = ApiKey.key;
  GetCastPeople getCastPeople;
  GetCastPeopleCubit({required this.getCastPeople})
      : super(GetCastPeopleInitial());

  getPeopleCast(Movie movie) async {
    emit(GetCastPeopleIsLoading());
    final failureOrListCast =
        await getCastPeople(Params(id: movie.id, key: key));
    _eitherSuccessOrErrorState(failureOrListCast);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, List<CastPeople>> failureOrListCast,
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
