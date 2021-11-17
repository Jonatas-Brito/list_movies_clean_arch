part of 'get_cast_people_cubit.dart';

abstract class GetCastPeopleState extends Equatable {
  const GetCastPeopleState();

  @override
  List<Object> get props => [];
}

class GetCastPeopleInitial extends GetCastPeopleState {}

class GetCastPeopleIsLoading extends GetCastPeopleState {}

class GetCastPeopleIsSuccessful extends GetCastPeopleState {
  final List<CastPeople> listCast;
  const GetCastPeopleIsSuccessful({required this.listCast});
}

class GetCastPeopleIsError extends GetCastPeopleState {
  final String errorMessage;
  const GetCastPeopleIsError({required this.errorMessage});
}
