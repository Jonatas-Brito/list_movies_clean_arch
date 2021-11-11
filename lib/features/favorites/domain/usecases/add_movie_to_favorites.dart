import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/favorites/domain/usecases/params/favorite_params.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef ThisAddUsecase = UseCase<Movie, FavoriteParams>;

class AddMovieToFavorites implements ThisAddUsecase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const AddMovieToFavorites({required this.favoriteReposiry});

  @override
  Future<Either<Failure, Movie>> call(FavoriteParams params) async {
    return await favoriteReposiry.addMovieToCachedFavorites(params.movie);
  }
}
