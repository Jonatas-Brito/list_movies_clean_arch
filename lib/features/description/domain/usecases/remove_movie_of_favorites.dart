import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/description/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/description/domain/usecases/params/favorite_params.dart';

typedef ThisRemoveUseCase = UseCase<void, FavoriteParams>;

class RemoveMovieOfFavorites implements ThisRemoveUseCase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const RemoveMovieOfFavorites({required this.favoriteReposiry});
  @override
  Future<Either<Failure, void>> call(FavoriteParams params) async {
    return await favoriteReposiry.removeMovieOfFavorites(params.movie);
  }
}
