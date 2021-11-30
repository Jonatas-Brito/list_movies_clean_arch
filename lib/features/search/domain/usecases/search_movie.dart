import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/search/domain/repositories/search_movies_repository.dart';

typedef SearchUseCase = UseCase<List<Movie>, Params>;

class SearchMovie implements SearchUseCase {
  final SearchRepository searchRepository;
  const SearchMovie(this.searchRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(Params params) {
    return searchRepository.searchMovies(params.text, params.movies);
  }
}

class Params extends Equatable {
  final String text;
  final List<Movie> movies;
  const Params({required this.text, required this.movies});
  @override
  List<Object?> get props => [];
}
