import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/key/tmdb_key.dart';
import 'package:movies_list/features/home/data/datasources/client_http_services_data_sources.dart';
import 'package:movies_list/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/data/models/people_credits_models.dart';
import '../../../../fixtures/fixtures_reader.dart';
import 'movies_remote_data_source_test.mocks.dart';

@GenerateMocks([HttpServiceImpl])
void main() {
  MockHttpServiceImpl mockHttpServiceImpl = MockHttpServiceImpl();

  MoviesRemoteDataSourceImpl dataSource =
      MoviesRemoteDataSourceImpl(client: mockHttpServiceImpl);

  Map<String, dynamic> tMapMovies = jsonDecode(fixture('movie.json'));

  List _dynamicList = tMapMovies['results'];
  int id = 0;
  MovieModel tMapMoviesModel = MovieModel.fromJson(_dynamicList[0]);

  Map<String, dynamic> tMapTrailers = jsonDecode(fixture('trailer_id.json'));

  Map<String, dynamic> tMapCast = jsonDecode(fixture('cast.json'));

  List _dynamicListTrailer = tMapTrailers['results'];

  List _dynamicListCast = tMapCast['cast'];

  CastPeopleModel tMapCastPeople =
      CastPeopleModel.fromJson(_dynamicListCast[0]);

  // print(_dynamicListTrailer[0]['key']);
  String key = ApiKey.key;

  void setUpMockHttopClientSuccess200() {
    String uri =
        'https://api.themoviedb.org/3/movie/popular?api_key=$key&language=pt-BR&page=1';

    when(mockHttpServiceImpl.get(uri))
        .thenAnswer((_) async => http.Response(fixture('movie.json'), 200));
  }

  void setUpMockHttopClientSuccess200MoviesInTheaters() {
    String uri =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$key&language=pt-BR&page=1';
    when(mockHttpServiceImpl.get(uri))
        .thenAnswer((_) async => http.Response(fixture('movie.json'), 200));
  }

  void setUpMockHttopClientSuccess200YoutubeId() {
    tMapMoviesModel.trailerId = _dynamicListTrailer[0]['key'];

    String uri =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US';
    when(mockHttpServiceImpl.get(uri)).thenAnswer((realInvocation) async =>
        http.Response(fixture('trailer_id.json'), 200));
  }

  void setUpMockHttopClientSuccess200CastList() {
    tMapMoviesModel.castPeople = [tMapCastPeople];

    String uri =
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$key&language=en-US';
    when(mockHttpServiceImpl.get(uri)).thenAnswer(
        (realInvocation) async => http.Response(fixture('cast.json'), 200));
  }

  void setUpMockHttopClientFailure404orOther() {
    String uri =
        'https://api.themoviedb.org/3/movie/popular?api_key=$key&language=pt-BR&page=1';
    when(mockHttpServiceImpl.get(uri))
        .thenAnswer((_) async => http.Response('Somenthing went wrong', 404));
  }

  void setUpMockHttopClientFailure404orOtherMoviesInTheaters() {
    String uri =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$key&language=pt-BR&page=1';
    when(mockHttpServiceImpl.get(uri)).thenAnswer(
        (realInvocation) async => http.Response('Somenthing went wrong', 404));
  }

  void setUpMockHttopClientFailure404orOtherYoutubeId() {
    String uri =
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US';
    when(mockHttpServiceImpl.get(uri))
        .thenAnswer((_) async => http.Response('Somenthing went wrong', 404));
  }

  void setUpMockHttopClientFailure404orOtherCastList() {
    String uri =
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$key&language=en-US';
    when(mockHttpServiceImpl.get(uri))
        .thenAnswer((_) async => http.Response('Somenthing went wrong', 404));
  }

  group('getMoviesPopular', () {
    test(
        'should perform a GET request on a URL with "key" assigned a "queryParam"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200();

      String uri =
          'https://api.themoviedb.org/3/movie/popular?api_key=$key&language=pt-BR&page=1';
      // act
      await dataSource.getMoviesPopular(key);
      // assert
      verify(mockHttpServiceImpl.get(uri));
    });

    test('should return Movies when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200();
      // act
      final result = await dataSource.getMoviesPopular(key);
      // assert
      expect(result, equals([tMapMoviesModel]));
    });

    test('''should throw a ServerException when the
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOther();
      // act
      final call = dataSource.getMoviesPopular;
      // assert
      expect(call(key), throwsA(TypeMatcher<ServerException>()));
    });
  });

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  group('getMoviesInTheaters', () {
    test(
        'should perform a GET request on a URL with "key" assigned a "queryParam"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200MoviesInTheaters();
      String uri =
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$key&language=pt-BR&page=1';
      // act
      await dataSource.getMoviesInTheaters(key);
      // assert
      verify(mockHttpServiceImpl.get(uri));
    });

    test('should return Movies when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200MoviesInTheaters();
      // act
      final result = await dataSource.getMoviesInTheaters(key);
      print(result);
      // assert
      expect(result, equals([tMapMoviesModel]));
    });

    test('''should throw a ServerException when the
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOtherMoviesInTheaters();
      // act
      final call = dataSource.getMoviesInTheaters;
      // assert
      expect(call(key), throwsA(TypeMatcher<ServerException>()));
    });
  });

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  group('getTrailerId', () {
    test('should must perform a GET request on a URL with "movie.id" and "key"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200YoutubeId();
      String uri =
          'https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US';
      // act
      await dataSource.getYoutubeId(id, key);
      // assert
      verify(mockHttpServiceImpl.get(uri));
    });

    test('should return TrailerId when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200YoutubeId();
      // act
      final result = await dataSource.getYoutubeId(id, key);
      print(result);
      // assert
      expect(result, equals(tMapMoviesModel.trailerId));
    });

    test('''should throw a ServerException when the
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOtherYoutubeId();
      // act
      final call = dataSource.getYoutubeId;
      // assert
      expect(call(0, key), throwsA(TypeMatcher<ServerException>()));
    });
  });

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  group('getListCast', () {
    test('should must perform a GET request on a URL with "movie.id" and "key"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200CastList();
      String uri =
          'https://api.themoviedb.org/3/movie/$id/credits?api_key=$key&language=en-US';
      // act
      await dataSource.getCastPeople(id, key);
      // assert
      verify(mockHttpServiceImpl.get(uri));
    });

    test('should return [CastList] when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200CastList();
      // act
      final result = await dataSource.getCastPeople(id, key);
      print(result);
      // assert
      expect(result[0], equals(tMapCastPeople));
    });

    test('''should throw a ServerException when the
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOtherCastList();
      // act
      final call = dataSource.getCastPeople;
      // assert
      expect(call(0, key), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
