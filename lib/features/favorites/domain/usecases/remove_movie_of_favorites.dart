import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';

typedef ThisRemoveUseCase = UseCase<bool, FavoriteParams>;

class RemoveMovieOfFavorites implements ThisRemoveUseCase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const RemoveMovieOfFavorites({required this.favoriteReposiry});
  @override
  Future<Either<Failure, bool>> call(FavoriteParams params) async {
    return await favoriteReposiry.removeMovieOfFavorites(params.movie);
  }
}
