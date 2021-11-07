import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/key/tmdb_key.dart';
import 'package:movies_list/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:movies_list/features/home/data/models/movies_model.dart';

import '../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient = MockHttpClient();
  MoviesRemoteDataSourceImpl dataSource =
      MoviesRemoteDataSourceImpl(client: mockHttpClient);

  final tMovieModel = MovieModel.fromJson(jsonDecode(fixture('movie.json')));

  String key = ApiKey.key;

  void setUpMockHttopClientSuccess200() {
    when(() => mockHttpClient.get(Uri(
            path: 'https://api.themoviedb.org/3/movie/popular',
            queryParameters: {'api_key': key, 'language': 'pt-BR'})))
        .thenAnswer((_) async => http.Response(fixture('movie.json'), 200));
  }

  void setUpMockHttopClientSuccess200PopularMovies() {
    when(() => mockHttpClient.get(Uri(
            path: 'https://api.themoviedb.org/3/movie/now_playing',
            queryParameters: {'api_key': key, 'language': 'pt-BR'})))
        .thenAnswer((_) async => http.Response(fixture('movie.json'), 200));
  }

  void setUpMockHttopClientFailure404orOther() {
    when(() => mockHttpClient.get(Uri(
            path: 'https://api.themoviedb.org/3/movie/popular',
            queryParameters: {'api_key': key, 'language': 'pt-BR'})))
        .thenAnswer((_) async => http.Response('Somenthing went wrong', 404));
  }

  void setUpMockHttopClientFailure404orOtherMoviesInTheaters() {
    when(() => mockHttpClient.get(Uri(
            path: 'https://api.themoviedb.org/3/movie/now_playing',
            queryParameters: {'api_key': key, 'language': 'pt-BR'})))
        .thenAnswer((_) async => http.Response('Somenthing went wrong', 404));
  }

  group('getMoviesPopular', () {
    test(
        'should perform a GET request on a URL with "key" assigned a "queryParam"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200();
      // act
      await dataSource.getMoviesPopular(key);
      // assert
      verify(() => mockHttpClient.get(Uri(
          path: 'https://api.themoviedb.org/3/movie/popular',
          queryParameters: {'api_key': key, 'language': 'pt-BR'})));
    });

    test('should return Movies when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200();
      // act
      final result = await dataSource.getMoviesPopular(key);
      // assert
      expect(result, equals([tMovieModel]));
    });

    test('''should throw a ServerException when the 
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOther();
      // act
      final call = dataSource.getMoviesPopular;
      // assert
      expect(() => call(key), throwsA(TypeMatcher<ServerException>()));
    });
  });
  group('getMoviesInTheaters', () {
    test(
        'should perform a GET request on a URL with "key" assigned a "queryParam"',
        () async {
      // arrange
      setUpMockHttopClientSuccess200PopularMovies();
      // act
      await dataSource.getMoviesInTheaters(key);
      // assert
      verify(() => mockHttpClient.get(Uri(
          path: 'https://api.themoviedb.org/3/movie/now_playing',
          queryParameters: {'api_key': key, 'language': 'pt-BR'})));
    });

    test('should return Movies when the status code is 200 (success)',
        () async {
      // arrange
      setUpMockHttopClientSuccess200PopularMovies();
      // act
      final result = await dataSource.getMoviesInTheaters(key);
      // assert
      expect(result, equals([tMovieModel]));
    });

    test('''should throw a ServerException when the 
        response code is 404 or other than 200''', () async {
      // arrange
      setUpMockHttopClientFailure404orOtherMoviesInTheaters();
      // act
      final call = dataSource.getMoviesInTheaters;
      // assert
      expect(() => call(key), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
