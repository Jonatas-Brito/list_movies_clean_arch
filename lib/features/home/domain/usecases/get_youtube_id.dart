import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/movies_repository.dart';

typedef FutureYoutubeId = Future<Either<Failure, String>>;
typedef TrailerIdUseCase = UseCase<String, Params>;

class GetTrailerId implements TrailerIdUseCase {
  final MoviesRepository repository;
  const GetTrailerId(this.repository);

  @override
  FutureYoutubeId call(Params params) {
    return repository.getYoutubeId(params.id, params.key);
  }
}

class Params extends Equatable {
  final String key;
  final int id;

  const Params({required this.id, required this.key});

  @override
  List<Object?> get props => [key];
}
