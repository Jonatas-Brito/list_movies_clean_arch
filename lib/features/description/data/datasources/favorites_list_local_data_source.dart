import 'dart:convert';

import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesListLocalDataSource {
  /// Get the previously [List<Movie>] cached favorite movies list
  ///
  /// Throws [CachedException] if no cached data is present.
  Future<List<Movie>> retriveFavoritesMovies();

  Future<Movie> addMovieToCachedFavorites(Movie moviefavoriteToChache);
  Future<void> removeMovieOfFavorites(Movie moviefavoriteToChache);
}

const CACHED_NUMBER_FAVORITE_LIST = 'CACHED_NUMBER_FAVORITE_LIST';

class FavoritesListLocalDataSourceImpl implements FavoritesListLocalDataSource {
  final SharedPreferences sharedPreferences;
  const FavoritesListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Movie> addMovieToCachedFavorites(Movie moviefavoriteToChache) async {
    final checkForKey =
        sharedPreferences.containsKey(CACHED_NUMBER_FAVORITE_LIST);
    Movie selecMovie = moviefavoriteToChache;
    List<Movie> listFavoriteCache = [];
    try {
      if (checkForKey) {
        // dynamicList =
        //     jsonDecode(sharedPreferences.getString(CACHED_NUMBER_FAVORITE_LIST)!);
        // print("Type: ${dynamicList[0].runtimeType}");
        listFavoriteCache = jsonDecode(
            sharedPreferences.getString(CACHED_NUMBER_FAVORITE_LIST)!);
        // listFavoriteCache =

        //     dynamicList.map((e) => MovieModel.fromJson(e)).toList();
        bool containMovie =
            listFavoriteCache.any((movie) => movie.id == selecMovie.id);
        if (!containMovie) {
          listFavoriteCache.add(selecMovie);
        }
      } else {
        listFavoriteCache = [selecMovie];
      }
      await sharedPreferences.setString(
          CACHED_NUMBER_FAVORITE_LIST, jsonEncode(listFavoriteCache));
    } catch (e) {
      throw CachedException();
    }

    return selecMovie;
  }

  @override
  Future<void> removeMovieOfFavorites(Movie moviefavoriteToChache) async {
    final checkForKey =
        sharedPreferences.containsKey(CACHED_NUMBER_FAVORITE_LIST);
    Movie selecMovie = moviefavoriteToChache;
    // List dynamicList;
    List<Movie> listFavoriteCache = [];
    try {
      if (checkForKey) {
        // dynamicList =
        //     jsonDecode(sharedPreferences.getString(CACHED_NUMBER_FAVORITE_LIST)!);
        listFavoriteCache = jsonDecode(
            sharedPreferences.getString(CACHED_NUMBER_FAVORITE_LIST)!);

        if (listFavoriteCache.length > 0) {
          // listFavoriteCache =
          //     dynamicList.map((e) => MovieModel.fromJson(e)).toList();
          bool containMovie =
              listFavoriteCache.any((movie) => movie.id == selecMovie.id);
          if (containMovie) {
            listFavoriteCache.removeWhere((movie) => movie.id == selecMovie.id);
            if (listFavoriteCache.length == 0) {
              await sharedPreferences.remove(CACHED_NUMBER_FAVORITE_LIST);
            } else {
              await sharedPreferences.setString(
                  CACHED_NUMBER_FAVORITE_LIST, jsonEncode(listFavoriteCache));
            }
          }
        }
      }
    } catch (e) {
      throw CachedException();
    }
  }

  @override
  Future<List<Movie>> retriveFavoritesMovies() async {
    final checkForKey =
        sharedPreferences.containsKey(CACHED_NUMBER_FAVORITE_LIST);
    List dynamicList;
    List<Movie> listFavoriteCache = [];
    try {
      if (checkForKey) {
        dynamicList = jsonDecode(
            sharedPreferences.getString(CACHED_NUMBER_FAVORITE_LIST)!);
        listFavoriteCache =
            dynamicList.map((e) => MovieModel.fromJson(e)).toList();
      }
      return Future.value(listFavoriteCache);
    } catch (e) {
      throw CachedException();
    }
  }
}
