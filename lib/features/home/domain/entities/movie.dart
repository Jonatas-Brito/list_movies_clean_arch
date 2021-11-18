import 'package:equatable/equatable.dart';

import 'cast_people.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String imagePath;
  final double popularity;
  final String overview;
  final int voteCount;
  bool? isFavorite;
  final String releaseDate;
  final String bannerPath;
  List<CastPeople> castPeople;
  final double voteAverage;
  String trailerId;

  Movie({
    required this.id,
    required this.trailerId,
    required this.title,
    required this.castPeople,
    required this.isFavorite,
    required this.voteAverage,
    required this.bannerPath,
    required this.imagePath,
    required this.overview,
    required this.popularity,
    required this.voteCount,
    required this.releaseDate,
  });

  Movie.empty({
    this.id = 0,
    this.title = '',
    this.imagePath = '',
    this.trailerId = '',
    this.isFavorite = false,
    this.castPeople = const <CastPeople>[],
    this.bannerPath = '',
    this.voteAverage = 0,
    this.releaseDate = '',
    this.popularity = 0.0,
    this.overview = '',
    this.voteCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imagePath,
        isFavorite,
        bannerPath,
        voteAverage,
        releaseDate,
        trailerId,
        popularity,
        overview,
        voteCount,
      ];
}
