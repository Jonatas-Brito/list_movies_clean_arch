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
    Movie selecMovie = moviefavoriteToChache;
    List<Movie> listFavoriteCache = [];
    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);
    try {
      selecMovie.isFavorite = true;
      if (checkForKey) {
        listFavoriteCache = _returnFavoritesMovies();
        bool containIdMovie =
            listFavoriteCache.any((movie) => movie.id == selecMovie.id);
        if (!containIdMovie) {
          listFavoriteCache.add(selecMovie);
        }
      } else {
        listFavoriteCache = [selecMovie];
      }
      await sharedPreferences.setString(
          CACHED_MOVIE_FAVORITE_LIST, jsonEncode(listFavoriteCache));
    } catch (e) {
      selecMovie = Movie.empty();
      throw CachedException();
    }

    return selecMovie;
  }

  @override
  Future<Movie> removeMovieOfFavorites(Movie moviefavoriteToChache) async {
    // await sharedPreferences.clear();
    Movie selecMovie = moviefavoriteToChache;
    List<Movie> listFavoriteCache = [];
    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_FAVORITE_LIST);

    try {
      if (checkForKey) {
        listFavoriteCache = _returnFavoritesMovies();

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
            listFavoriteCache.removeWhere((movie) => movie.id == selecMovie.id);
            listFavoriteCache.forEach((movie) {
              if (movie.id == selecMovie.id) {}
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
    if (checkForKey) {
      dynamicList =
          jsonDecode(sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);
      dynamicList.forEach((movie) {
        Movie movieForFavorites = MovieModel.fromJson(movie);
        movieForFavorites.isFavorite = true;
        listFavoriteCache.add(movieForFavorites);
      });
    }
    return Future.value(listFavoriteCache);
  }

  List<Movie> _returnFavoritesMovies() {
    List dynamicList;
    List<Movie> listFavoriteCache = [];
    dynamicList =
        jsonDecode(sharedPreferences.getString(CACHED_MOVIE_FAVORITE_LIST)!);

    dynamicList.forEach((movie) {
      listFavoriteCache.add(MovieModel.fromJson(movie));
    });

    return listFavoriteCache;
  }
}
