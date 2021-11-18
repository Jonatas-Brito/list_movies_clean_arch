import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/entities/movie.dart';
import '../repositories/movies_favorite_repository.dart';
import 'params/favorite_params.dart';

typedef ThisAddUsecase = UseCase<Movie, FavoriteParams>;

class AddMovieToFavorites implements ThisAddUsecase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const AddMovieToFavorites({required this.favoriteReposiry});

  @override
  Future<Either<Failure, Movie>> call(FavoriteParams params) async {
    return await favoriteReposiry.addMovieToCachedFavorites(params.movie);
  }
}
