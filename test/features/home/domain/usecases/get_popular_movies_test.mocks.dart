// Mocks generated by Mockito 5.0.15 from annotations
// in movies_list/test/features/home/domain/usecases/get_popular_movies_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_list/core/error/failure.dart' as _i5;
import 'package:movies_list/features/home/domain/entities/cast_people.dart'
    as _i7;
import 'package:movies_list/features/home/domain/entities/movie.dart' as _i6;
import 'package:movies_list/features/home/domain/repositories/movies_repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [MoviesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMoviesRepository extends _i1.Mock implements _i3.MoviesRepository {
  MockMoviesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getMoviesPopular(
          String? key) =>
      (super.noSuchMethod(Invocation.method(#getMoviesPopular, [key]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> getMoviesInTheaters(
          String? key) =>
      (super.noSuchMethod(Invocation.method(#getMoviesInTheaters, [key]),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> getYoutubeId(
          int? id, String? key) =>
      (super.noSuchMethod(Invocation.method(#getYoutubeId, [id, key]),
              returnValue: Future<_i2.Either<_i5.Failure, String>>.value(
                  _FakeEither_0<_i5.Failure, String>()))
          as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i7.CastPeople>>> getCast(
          int? id, String? key) =>
      (super.noSuchMethod(Invocation.method(#getCast, [id, key]),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i7.CastPeople>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i7.CastPeople>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i7.CastPeople>>>);
  @override
  String toString() => super.toString();
}
