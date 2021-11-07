import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_list/features/home/data/models/movies_model.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  final tMovieModel = MovieModel.fromJson(jsonDecode(fixture('movie.json')));

  test('should be a subclass of MovieEntity', () async {
    //assert
    expect(tMovieModel, isA<Movie>());
  });

  test('fromJson - should return a valid model', () async {
    // arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('movie.json'));
    // act
    final result = MovieModel.fromJson(jsonMap);
    // assert
    expect(result, tMovieModel);
  });

  test('toJson - should return a JSON map containing the proper data',
      () async {
    // act
    final result = tMovieModel.toJson();
    // assert
    final expectedMap = {
      "title": "Venom: Let There Be Carnage",
      "popularity": 6093.846,
      "imagePath": "/rjkmN1dniUHVYAtwuV3Tji7FsDO.jpg",
      "releaseDate": "2021-09-30",
    };
    expect(result, expectedMap);
  });
}
