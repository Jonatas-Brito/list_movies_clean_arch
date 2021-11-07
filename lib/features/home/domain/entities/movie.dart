import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String imagePath;
  final double popularity;
  final String releaseDate;

  const Movie({
    required this.title,
    required this.imagePath,
    required this.popularity,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [title, imagePath, popularity, releaseDate];
}
