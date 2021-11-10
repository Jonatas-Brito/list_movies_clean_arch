import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef ThisRemoveUseCase = UseCase<List<Movie>, NoParams>;

class RetriveMoviesFavorites implements ThisRemoveUseCase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const RetriveMoviesFavorites({required this.favoriteReposiry});
  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await favoriteReposiry.retriveMoviesFavorites();
  }
}
