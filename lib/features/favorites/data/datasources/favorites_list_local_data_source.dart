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
  Future<Movie> removeMovieOfFavorites(Movie moviefavoriteToChache);
}

const CACHED_MOVIE_FAVORITE_LIST = 'CACHED_MOVIE_FAVORITE_LIST';

class FavoritesListLocalDataSourceImpl implements FavoritesListLocalDataSource {
  final SharedPreferences sharedPreferences;
  const FavoritesListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Movie> addMovieToCachedFavorites(Movie moviefavoriteToChache) async {
    // await sharedPreferences.clear();
    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);
    print("Contain Chace:$checkForKey");
    Movie selecMovie = moviefavoriteToChache;
    List<Movie> listFavoriteCache = [];
    try {
      if (checkForKey) {
        selecMovie.isFavorite = true;

        List dynamicList = jsonDecode(
            sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);

        dynamicList.forEach((movie) {
          listFavoriteCache.add(MovieModel.fromJson(movie));
        });
        print("Tamanho: ${listFavoriteCache[0].isFavorite}");
        bool containIdMovie =
            listFavoriteCache.any((movie) => movie.id == selecMovie.id);
        if (!containIdMovie) {
          print("nesse caso entrei");
          listFavoriteCache.add(selecMovie);
        }
      } else {
        var a = "Cached successful";
        print("nesse caso não entrei");
        listFavoriteCache = [selecMovie];
      }

      await sharedPreferences.setString(
          CACHED_MOVIE_FAVORITE_LIST, jsonEncode(listFavoriteCache));
    } catch (e) {
      print("deu ruim");
      selecMovie.isFavorite = false;
      throw CachedException();
    }

    return selecMovie;
  }

  @override
  Future<Movie> removeMovieOfFavorites(Movie moviefavoriteToChache) async {
    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);
    Movie selecMovie = moviefavoriteToChache;
    List<Movie> listFavoriteCache = [];

    try {
      if (checkForKey) {
        List dynamicList = jsonDecode(
            sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);

        listFavoriteCache =
            dynamicList.map((e) => MovieModel.fromJson(e)).toList();

        if (listFavoriteCache.length > 0) {
          bool containIdMovie =
              listFavoriteCache.any((movie) => movie.id == selecMovie.id);
          if (containIdMovie) {
            listFavoriteCache.forEach((movie) {
              if (movie.id == selecMovie.id) {
                movie.isFavorite = false;
                selecMovie.isFavorite = movie.isFavorite;
              }
            });
            print("Favorite: ${selecMovie.isFavorite}");
            listFavoriteCache.removeWhere((movie) => movie.id == selecMovie.id);
            listFavoriteCache.forEach((movie) {
              if (movie.id == selecMovie.id) {
                print("O id: ${[movie.id]} não foi removido.");
              }
            });
            if (listFavoriteCache.length == 0) {
              await sharedPreferences.remove(CACHED_MOVIE_FAVORITE_LIST);
            } else {
              await sharedPreferences.setString(
                  CACHED_MOVIE_FAVORITE_LIST, jsonEncode(listFavoriteCache));
            }
          }
        }
      }
    } catch (e) {
      selecMovie.isFavorite = false;
      throw CachedException();
    }
    return selecMovie;
  }

  @override
  Future<List<Movie>> retriveFavoritesMovies() async {
    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);
    List dynamicList;
    List<Movie> listFavoriteCache = [];
    try {
      if (checkForKey) {
        dynamicList = jsonDecode(
            sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);
        listFavoriteCache =
            dynamicList.map((e) => MovieModel.fromJson(e)).toList();
      }
      return Future.value(listFavoriteCache);
    } catch (e) {
      throw CachedException();
    }
  }
}
