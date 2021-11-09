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

  @override
  List<Object?> get props => [
        id,
        title,
        imagePath,
        popularity,
        overview,
        voteCount,
        releaseDate,
      ];
}
