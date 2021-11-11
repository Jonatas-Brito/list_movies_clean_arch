// Mocks generated by Mockito 5.0.15 from annotations
// in movies_list/test/features/favorites/data/repositories/movies_favorite_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movies_list/features/favorites/data/datasources/favorites_list_local_data_source.dart'
    as _i3;
import 'package:movies_list/features/home/domain/entities/movie.dart' as _i5;
import 'package:shared_preferences/shared_preferences.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeSharedPreferences_0 extends _i1.Fake
    implements _i2.SharedPreferences {}

/// A class which mocks [FavoritesListLocalDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoritesListLocalDataSourceImpl extends _i1.Mock
    implements _i3.FavoritesListLocalDataSourceImpl {
  MockFavoritesListLocalDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SharedPreferences get sharedPreferences =>
      (super.noSuchMethod(Invocation.getter(#sharedPreferences),
          returnValue: _FakeSharedPreferences_0()) as _i2.SharedPreferences);
  @override
  _i4.Future<bool> addMovieToCachedFavorites(
          _i5.Movie? moviefavoriteToChache) =>
      (super.noSuchMethod(
          Invocation.method(
              #addMovieToCachedFavorites, [moviefavoriteToChache]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<bool> removeMovieOfFavorites(_i5.Movie? moviefavoriteToChache) =>
      (super.noSuchMethod(
          Invocation.method(#removeMovieOfFavorites, [moviefavoriteToChache]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i5.Movie>> retriveFavoritesMovies() =>
      (super.noSuchMethod(Invocation.method(#retriveFavoritesMovies, []),
              returnValue: Future<List<_i5.Movie>>.value(<_i5.Movie>[]))
          as _i4.Future<List<_i5.Movie>>);
  @override
  String toString() => super.toString();
}