import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef FutureMovies = Future<List<Movie>>;

abstract class MoviesRemoteDataSource {
  FutureMovies getMoviesPopular(String key);

  FutureMovies getMoviesInTheaters(String key);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;
  const MoviesRemoteDataSourceImpl({required this.client});

  @override
  FutureMovies getMoviesInTheaters(String key) =>
      _getMovies('https://api.themoviedb.org/3/movie/now_playing', key);

  @override
  FutureMovies getMoviesPopular(String key) =>
      _getMovies('https://api.themoviedb.org/3/movie/popular', key);

  FutureMovies _getMovies(String url, String key) async {
    final response = await client.get(
        Uri(path: url, queryParameters: {'api_key': key, 'language': 'pt-BR'}));

    if (response.statusCode == 200) {
      List<Movie> _movies = [];
      Map<String, dynamic> _mapBody = jsonDecode(response.body);
      List _dynamicList = _mapBody['results'];
      _movies = _dynamicList.map((e) => MovieModel.fromJson(e)).toList();

      return _movies;
    } else {
      throw ServerException();
    }

    // return response
  }
}
