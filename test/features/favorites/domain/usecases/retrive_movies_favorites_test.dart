// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movies_list/core/error/failure.dart';
// import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart';
// import 'package:movies_list/features/favorites/domain/usecases/retrive_movies_favorites.dart';
// import 'package:movies_list/features/home/domain/entities/movie.dart';

// import 'retrive_movies_favorites_test.mocks.dart';

// @GenerateMocks([MoviesFavoriteReposiry])
void main() {
  // MockMoviesFavoriteReposiry favoriteReposiry = MockMoviesFavoriteReposiry();
  // RetriveMoviesFavorites usecase =
  //     RetriveMoviesFavorites(favoriteReposiry: favoriteReposiry);

  // NoParams noParams = NoParams();

  // final movie = Movie.empty(id: 1);
  // final listMovies = <Movie>[movie];

  // test('should return movies favorites if cached is successfull', () async {
  //   // arrange
  //   when(favoriteReposiry.retriveMoviesFavorites())
  //       .thenAnswer((_) async => Right(listMovies));
  //   // act
  //   final result = await usecase(noParams);
  //   // assert
  //   expect(result, Right(listMovies));
  // });

  // test('should return [CachedFailure] if removed proccess fails', () async {
  //   // arrange
  //   when(favoriteReposiry.retriveMoviesFavorites())
  //       .thenAnswer((_) async => Left(CachedToRetriveFailure()));
  //   // act
  //   final result = await usecase(noParams);
  //   // assert
  //   expect(result.fold((l) => Left(CachedToRetriveFailure()), (r) => null),
  //       Left(CachedToRetriveFailure()));
  //   expect(result, Left(CachedToRetriveFailure()));
  // });
}
