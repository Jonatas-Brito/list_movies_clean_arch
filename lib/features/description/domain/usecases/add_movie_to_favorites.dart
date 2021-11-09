import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/description/domain/repositories/movies_favorite_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef ThisAddUsecase = UseCase<void, FavoriteParams>;

class AddMovieToFavorite implements ThisAddUsecase {
  final MoviesFavoriteReposiry favoriteReposiry;
  const AddMovieToFavorite(this.favoriteReposiry);

  @override
  Future<Either<Failure, void>> call(FavoriteParams params) async {
    return await favoriteReposiry.addMovieToCachedFavorite(params.movie);
  }
}

class FavoriteParams extends Equatable {
  final Movie movie;
  const FavoriteParams({required this.movie});

  @override
  List<Object?> get props => [movie];
}
