import 'dart:convert';

import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/key/base_key.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DownloadListLocalDataSource {
  /// Get the previously [List<Movie>] cached movies list for download
  /// Add [Movie] to movies list for download
  /// Remove [Movie] to movies list for download
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Movie>> retriveMoviesForDownload();
  Future<Movie> addMoviesForDownload(Movie movieForDownloadForChache);
  Future<Movie> removeMoviesForDownload(Movie movieForDownloadForChache);
}

class DownloadListLocalDataSourceImpl implements DownloadListLocalDataSource {
  final SharedPreferences sharedPreferences;
  const DownloadListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Movie> addMoviesForDownload(
    Movie movieForDownloadForChache,
  ) async {
    // await sharedPreferences.clear();

    const String CACHED_MOVIE_DOWNLOAD_LIST =
        BaseKey.CACHED_MOVIE_DOWNLOAD_LIST;

    Movie selecMovie = movieForDownloadForChache;

    List<Movie> downloadListCache = [];

    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_DOWNLOAD_LIST);
    try {
      selecMovie.hasDownloaded = true;
      if (checkForKey) {
        downloadListCache = _returnDownloadListMovies();
        bool containIdMovie =
            downloadListCache.any((movie) => movie.id == selecMovie.id);
        if (!containIdMovie) {
          downloadListCache.add(selecMovie);
        }
      } else {
        downloadListCache = [selecMovie];
      }
      await sharedPreferences.setString(
          CACHED_MOVIE_DOWNLOAD_LIST, jsonEncode(downloadListCache));
    } catch (e) {
      selecMovie = Movie.empty();
      throw CachedException();
    }

    return selecMovie;
  }

  @override
  Future<Movie> removeMoviesForDownload(Movie movieForDownloadForChache) async {
    // await sharedPreferences.clear();

    const String CACHED_MOVIE_DOWNLOAD_LIST =
        BaseKey.CACHED_MOVIE_DOWNLOAD_LIST;

    Movie selecMovie = movieForDownloadForChache;

    List<Movie> downloadListCache = [];

    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_DOWNLOAD_LIST);

    try {
      if (checkForKey) {
        downloadListCache = _returnDownloadListMovies();

        if (downloadListCache.length > 0) {
          bool containIdMovie =
              downloadListCache.any((movie) => movie.id == selecMovie.id);
          if (containIdMovie) {
            downloadListCache.forEach((movie) {
              if (movie.id == selecMovie.id) {
                movie.hasDownloaded = false;
                selecMovie.hasDownloaded = movie.hasDownloaded;
              }
            });

            downloadListCache.removeWhere((movie) => movie.id == selecMovie.id);

            if (downloadListCache.length == 0) {
              await sharedPreferences.remove(CACHED_MOVIE_DOWNLOAD_LIST);
            } else {
              await sharedPreferences.setString(
                  CACHED_MOVIE_DOWNLOAD_LIST, jsonEncode(downloadListCache));
            }
          }
        }
      }
    } catch (e) {
      selecMovie.hasDownloaded = false;
      throw CachedException();
    }
    return selecMovie;
  }

  @override
  Future<List<Movie>> retriveMoviesForDownload() {
    const String CACHED_MOVIE_DOWNLOAD_LIST =
        BaseKey.CACHED_MOVIE_DOWNLOAD_LIST;

    final checkForKey =
        sharedPreferences.containsKey(CACHED_MOVIE_DOWNLOAD_LIST);

    List dynamicList;

    List<Movie> downloadListCache = [];

    if (checkForKey) {
      dynamicList =
          jsonDecode(sharedPreferences.getString(CACHED_MOVIE_DOWNLOAD_LIST)!);
      dynamicList.forEach((movie) {
        Movie movieForDownloadList = MovieModel.fromJson(movie);
        movieForDownloadList.hasDownloaded = true;
        downloadListCache.add(movieForDownloadList);
      });
    }
    return Future.value(downloadListCache);
  }

  List<Movie> _returnDownloadListMovies() {
    const String CACHED_MOVIE_DOWNLOAD_LIST =
        BaseKey.CACHED_MOVIE_DOWNLOAD_LIST;

    List dynamicList;

    List<Movie> downloadListCache = [];

    dynamicList =
        jsonDecode(sharedPreferences.getString(CACHED_MOVIE_DOWNLOAD_LIST)!);

    dynamicList.forEach((movie) {
      downloadListCache.add(MovieModel.fromJson(movie));
    });

    return downloadListCache;
  }
}
