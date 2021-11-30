// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:movies_list/core/error/exceptions.dart';
// import 'package:movies_list/core/key/base_key.dart';
// import 'package:movies_list/features/favorites/data/datasources/favorites_list_local_data_source.dart';
// import 'package:movies_list/features/home/data/models/movies_model.dart';
// import 'package:movies_list/features/home/domain/entities/movie.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../fixtures/fixtures_reader.dart';
// import 'favorites_list_local_data_source_test.mocks.dart';

// @GenerateMocks([SharedPreferences])
void main() {
  // MockSharedPreferences mockSharedPreferences = MockSharedPreferences();

  // const CACHED_MOVIE_FAVORITE_LIST = BaseKey.CACHED_MOVIE_FAVORITE_LIST;

  // FavoritesListLocalDataSourceImpl localDataSource =
  //     FavoritesListLocalDataSourceImpl(
  //         sharedPreferences: mockSharedPreferences);
  // Map<String, dynamic> tMapMovies = jsonDecode(fixture('movie.json'));
  // List dynamicList = tMapMovies['results'];
  // List<Movie> moviesFavorites = [];
  // dynamicList
  //     .forEach((movie) => moviesFavorites.add(MovieModel.fromJson(movie)));
  // Movie movie = moviesFavorites[0];

  // group('addToFavoritesMovies', () {
  //   test(
  //       'should add [Movie] to ListMoviesFavorites at SharedPreferences is cache process is successful and return [Movie.isFavorite = true] for movie added when added',
  //       () async {
  //     // arrange
  //     when(mockSharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((_) => true);
  //     when(mockSharedPreferences.getString(any))
  //         .thenAnswer((realInvocation) => jsonEncode(moviesFavorites));
  //     when(mockSharedPreferences.setString(
  //             CACHED_MOVIE_FAVORITE_LIST, jsonEncode(moviesFavorites)))
  //         .thenAnswer((_) async => false);
  //     // act
  //     mockSharedPreferences.setString(
  //         CACHED_MOVIE_FAVORITE_LIST, jsonEncode(moviesFavorites));
  //     final result = await localDataSource.addMovieToCachedFavorites(movie);

  //     // assert
  //     final expectedJsonString = jsonEncode(moviesFavorites);
  //     verify(mockSharedPreferences.setString(
  //         CACHED_MOVIE_FAVORITE_LIST, expectedJsonString));
  //     expect(result, movie);
  //     expect(result.isFavorite, true);
  //   });
  //   setUp(() {
  //     mockSharedPreferences = MockSharedPreferences();
  //     localDataSource = FavoritesListLocalDataSourceImpl(
  //         sharedPreferences: mockSharedPreferences);
  //   });

  //   test('should return [CachedException] if cache proccess is fails',
  //       () async {
  //     // arrange
  //     when(mockSharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((realInvocation) => true);

  //     // act
  //     final call = localDataSource.addMovieToCachedFavorites;

  //     // assert
  //     expect(call(movie), throwsA(TypeMatcher<CachedException>()));
  //   });
  // });

  // group('removeOfFavorites', () {
  //   test(
  //       'should remove [Movie] of ListMoviesFavorites at SharedPrefences is cache proccess is successful and return [Movie.isFavorite = false] for movie removed when removed',
  //       () async {
  //     // arrange
  //     when(mockSharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((_) => true);

  //     when(mockSharedPreferences.getString(any))
  //         .thenAnswer((realInvocation) => jsonEncode(moviesFavorites));

  //     when(mockSharedPreferences.setString(
  //             CACHED_MOVIE_FAVORITE_LIST, jsonEncode(moviesFavorites)))
  //         .thenAnswer((_) async => false);
  //     when(mockSharedPreferences.remove(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((_) async => true);

  //     // act
  //     mockSharedPreferences.setString(
  //         CACHED_MOVIE_FAVORITE_LIST, jsonEncode(moviesFavorites));
  //     final result = await localDataSource.removeMovieOfFavorites(movie);

  //     // assert
  //     final expectedJsonString = jsonEncode(moviesFavorites);
  //     verify(mockSharedPreferences.setString(
  //         CACHED_MOVIE_FAVORITE_LIST, expectedJsonString));
  //     expect(result, movie);
  //     expect(result.isFavorite, false);
  //   });
  //   setUp(() {
  //     mockSharedPreferences = MockSharedPreferences();
  //     localDataSource = FavoritesListLocalDataSourceImpl(
  //         sharedPreferences: mockSharedPreferences);
  //   });
  //   test('should return [CachedException] if cache proccess is fails',
  //       () async {
  //     // arrange
  //     when(mockSharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((realInvocation) => true);
  //     // act
  //     final call = localDataSource.removeMovieOfFavorites;

  //     // assert
  //     expect(call(movie), throwsA(TypeMatcher<CachedException>()));
  //   });
  // });

  // group('retriveFavoritesMovies', () {
  //   setUp(() {
  //     moviesFavorites[0].isFavorite = true;
  //   });
  //   test(
  //       'should return [List Movies] of SharedPreferences if cache proccess is successful',
  //       () async {
  //     // arrange
  //     when(mockSharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((_) => true);
  //     // arrange
  //     when(mockSharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST))
  //         .thenAnswer((_) => jsonEncode(moviesFavorites));
  //     // act
  //     final result = await localDataSource.retriveFavoritesMovies();
  //     // assert
  //     expect(result, moviesFavorites);
  //   });
  // });
}
