import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/entities/movie.dart';
import '../repositories/movies_favorite_repository.dart';
import 'params/favorite_params.dart';

typedef ThisRemoveUseCase = UseCase<Movie, FavoriteParams>;

class RemoveMovieOfFavorites implements ThisRemoveUseCase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const RemoveMovieOfFavorites({required this.favoriteReposiry});
  @override
  Future<Either<Failure, Movie>> call(FavoriteParams params) async {
    return await favoriteReposiry.removeMovieOfFavorites(params.movie);
  }
}
