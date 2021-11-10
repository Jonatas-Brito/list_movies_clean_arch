import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';

typedef ThisAddUsecase = UseCase<void, FavoriteParams>;

class AddMovieToFavorite implements ThisAddUsecase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const AddMovieToFavorite(this.favoriteReposiry);

  @override
  Future<Either<Failure, void>> call(FavoriteParams params) async {
    return await favoriteReposiry.addMovieToCachedFavorites(params.movie);
  }
}
