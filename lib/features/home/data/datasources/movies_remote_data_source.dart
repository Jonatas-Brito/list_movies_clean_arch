import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/data/models/people_credits_models.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/entities/people_credits.dart';

typedef FutureMovies = Future<List<Movie>>;

abstract class MoviesRemoteDataSource {
  FutureMovies getMoviesPopular(String key);

  FutureMovies getMoviesInTheaters(String key);

  Future<String> getYoutubeId(int id, String key);
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;
  const MoviesRemoteDataSourceImpl({required this.client});

  @override
  FutureMovies getMoviesInTheaters(String key) => _getMovies(
        'now_playing',
        key,
      );

  @override
  FutureMovies getMoviesPopular(String key) => _getMovies(
        'popular',
        key,
      );
  @override
  Future<String> getYoutubeId(int id, String key) => _getTrailersId(
        id,
        key,
      );

  Future<List<PeopleCredits>> _getPeopleCredits(int id, String key) async {
    List<PeopleCredits> peoples = <PeopleCredits>[];
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$key&language=en-US'));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List dynamicList = map['cast'];

      peoples = dynamicList
          .map((people) => PeopleCreditsModel.fromJson(people))
          .toList();

      // peoples.forEach((people) {
      //   print(people.department);
      //   // peoples
      //   //     .removeWhere((removePeople) => removePeople.department != 'Acting');
      // });
    } else
      throw ServerException();

    return peoples;
  }

  Future<String> _getTrailersId(int id, String key) async {
    String trailerId = '';
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US'));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);

      List dynamicList = map['results'];

      if (dynamicList.isNotEmpty) {
        trailerId = dynamicList[0]['key'];
      }
    } else {
      throw ServerException();
    }
    return trailerId;
  }

  FutureMovies _getMovies(String path, String key) async {
    String uri =
        'https://api.themoviedb.org/3/movie/$path?api_key=$key&language=pt-BR&page=1';

    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      List<Movie> _movies = [];
      Map<String, dynamic> _mapBody = jsonDecode(response.body);
      List _dynamicList = _mapBody['results'];

      _movies = _dynamicList.map((e) => MovieModel.fromJson(e)).toList();

      // _movies.forEach((movie) async {
      //   // movie.trailerId = await _getYoutubeId(movie.id, key);
      //   // movie.peopleCredits = await _getPeopleCredits(movie.id, key);
      // });

      return _movies;
    } else {
      throw ServerException();
    }

    // return response
  }

  // Future<String> getYoutubeId(int id, String key) async {
  //   String trailerId = '';
  //   final response = await client.get(Uri.parse(
  //       'https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US'));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> map = jsonDecode(response.body);

  //     List dynamicList = map['results'];

  //     if (dynamicList.isNotEmpty) {
  //       trailerId = dynamicList[0]['key'];
  //     }
  //   } else {
  //     throw ServerException();
  //   }
  //   return trailerId;
  // }

}
