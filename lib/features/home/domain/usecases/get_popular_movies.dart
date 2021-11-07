import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

typedef FutureGetMovies = Future<Either<Failure, List<Movie>>>;
typedef Usecase = UseCase<List<Movie>, Params>;

class GetPopularMovies implements Usecase {
  final MoviesRepository repository;
  const GetPopularMovies(this.repository);

  @override
  FutureGetMovies call(Params params) {
    return repository.getMoviesPopular(params.key);
  }
}

class Params extends Equatable {
  final String key;

  const Params({required this.key});

  @override
  List<Object?> get props => [key];
}
