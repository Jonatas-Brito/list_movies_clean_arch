import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/api_strings/features/home/api_strings_remote.dart';
import '../../domain/entities/cast_people.dart';
import '../../domain/entities/movie.dart';
import '../models/movies_model.dart';
import '../models/people_credits_models.dart';

typedef FutureMovies = Future<List<Movie>>;
typedef FutureCast = Future<List<CastPeople>>;

abstract class MoviesRemoteDataSource {
  FutureMovies getMoviesPopular(String key);

  FutureMovies getMoviesInTheaters(String key);

  Future<String> getYoutubeId(int id, String key);

  FutureCast getCastPeople(int id, String key);
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

  @override
  FutureCast getCastPeople(int id, String key) => _getCastPeople(
        id,
        key,
      );

  FutureCast _getCastPeople(int id, String key) async {
    List<CastPeople> people = <CastPeople>[];
    final response =
        await client.get(Uri.parse(ApiStringsHome().uriCast(id, key)));

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      List dynamicList = map['cast'];

      people = dynamicList
          .map((people) => CastPeopleModel.fromJson(people))
          .toList();
    } else
      throw ServerException();

    return people;
  }

  Future<String> _getTrailersId(int id, String key) async {
    String trailerId = '';
    final response =
        await client.get(Uri.parse(ApiStringsHome().uriTrailer(id, key)));

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
    String uri = ApiStringsHome().uriMovies(path, key);

    final response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      List<Movie> _movies = [];
      Map<String, dynamic> _mapBody = jsonDecode(response.body);
      List _dynamicList = _mapBody['results'];

      _movies = _dynamicList.map((e) => MovieModel.fromJson(e)).toList();

      return _movies;
    } else {
      throw ServerException();
    }
  }
}
