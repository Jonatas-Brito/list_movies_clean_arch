// Mocks generated by Mockito 5.0.15 from annotations
// in movies_list/test/features/favorites/domain/usecases/add_movie_to_favorites_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_list/core/error/failure.dart' as _i5;
import 'package:movies_list/features/favorites/domain/repositories/movies_favorite_repository.dart'
    as _i3;
import 'package:movies_list/features/home/domain/entities/movie.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [MoviesFavoriteReposiry].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesFavoriteReposiry extends _i1.Mock
    implements _i3.MoviesFavoriteReposiry {
  MockMoviesFavoriteReposiry() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>
      retriveMoviesFavorites() =>
          (super.noSuchMethod(Invocation.method(#retriveMoviesFavorites, []),
                  returnValue:
                      Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
                          _FakeEither_0<_i5.Failure, List<_i6.Movie>>()))
              as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> addMovieToCachedFavorites(
          _i6.Movie? movie) =>
      (super.noSuchMethod(
              Invocation.method(#addMovieToCachedFavorites, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, bool>>.value(
                  _FakeEither_0<_i5.Failure, bool>()))
          as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> removeMovieOfFavorites(
          _i6.Movie? movie) =>
      (super.noSuchMethod(Invocation.method(#removeMovieOfFavorites, [movie]),
              returnValue: Future<_i2.Either<_i5.Failure, bool>>.value(
                  _FakeEither_0<_i5.Failure, bool>()))
          as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  String toString() => super.toString();
}