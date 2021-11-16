part of 'gettrailerid_cubit.dart';

abstract class GetTrailerIdState extends Equatable {
  const GetTrailerIdState();

  @override
  List<Object> get props => [];
}

class GetTrailerIdInitial extends GetTrailerIdState {}

class GetTrailerIdIsLoading extends GetTrailerIdState {}

class GetTrailerIdIsSuccessful extends GetTrailerIdState {
  final Movie movie;
  const GetTrailerIdIsSuccessful({required this.movie});
}

class GetTrailerIdIsError extends GetTrailerIdState {
  final String errorMessage;
  const GetTrailerIdIsError({required this.errorMessage});
}
