import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/entities/movie.dart';
import '../repositories/movies_favorite_repository.dart';

typedef ThisRemoveUseCase = UseCase<List<Movie>, NoParams>;

class RetriveMoviesFavorites implements ThisRemoveUseCase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const RetriveMoviesFavorites({required this.favoriteReposiry});
  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await favoriteReposiry.retriveMoviesFavorites();
  }
}
