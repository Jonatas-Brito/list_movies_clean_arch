import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String imagePath;
  final double popularity;
  final String overview;
  final int voteCount;
  final String releaseDate;

  const Movie({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.overview,
    required this.popularity,
    required this.voteCount,
    required this.releaseDate,
  });

  const Movie.empty(
      {this.title = '',
      this.imagePath = '',
      this.popularity = 0.0,
      this.overview = '',
      this.voteCount = 0,
      this.releaseDate = '',
      this.id = 0});

  @override
  List<Object?> get props => [
        id,
        title,
        imagePath,
        releaseDate,
        popularity,
        voteCount,
        overview,
      ];
}
