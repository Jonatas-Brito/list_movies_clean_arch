import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/cast_people.dart';
import '../repositories/movies_repository.dart';

typedef FutureGetMovies = Future<Either<Failure, List<CastPeople>>>;
typedef Usecase = UseCase<List<CastPeople>, Params>;

class GetCastPeople implements Usecase {
  final MoviesRepository repository;
  const GetCastPeople(this.repository);

  @override
  FutureGetMovies call(Params params) {
    return repository.getCast(params.id, params.key);
  }
}

class Params extends Equatable {
  final String key;
  final int id;

  const Params({required this.key, required this.id});

  @override
  List<Object?> get props => [key, id];
}
