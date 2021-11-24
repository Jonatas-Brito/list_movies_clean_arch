import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/movies_repository.dart';

typedef FutureGetMovies = Future<Either<Failure, List<Movie>>>;
typedef Usecase = UseCase<List<Movie>, Params>;

class GetCastPeople implements Usecase {
  final MoviesRepository repository;
  const GetCastPeople(this.repository);

  @override
  FutureGetMovies call(Params params) {
    return repository.getCast(params.movies, params.key);
  }
}

class Params extends Equatable {
  final String key;
  final List<Movie> movies;

  const Params({required this.key, required this.movies});

  @override
  List<Object?> get props => [key, id];
}
