import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tMoviesModel = MovieModel(
      title: 'Test Movie',
      imagePath: 'image.png',
      popularity: 48.261451,
      releaseDate: '2016-08-03');
  test('should be a subclass of MovieEntity', () async {
    //assert
    expect(tMoviesModel, isA<Movie>());
  });

  test('fromJson - should return a valid model', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('movie.json'));
    // act
    final result = MovieModel.fromJson(jsonMap);
    // assert
    expect(result, tMoviesModel);
  });

  test('toJson - should return a JSON map containing the proper data',
      () async {
    // act
    final result = tMoviesModel.toJson();
    // assert
    final expectedMap = {
      "title": "Test Movie",
      "imagePath": "image.png",
      "releaseDate": "2016-08-03",
      "popularity": 48.261451
    };
    expect(result, expectedMap);
  });
}
