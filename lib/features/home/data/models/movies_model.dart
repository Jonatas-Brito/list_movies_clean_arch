import 'package:movies_list/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required String title,
    required String imagePath,
    required double popularity,
    required String releaseDate,
  }) : super(
            title: title,
            imagePath: imagePath,
            popularity: popularity,
            releaseDate: releaseDate);

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
      title: map['original_title'] != null ? map['original_title'] : null,
      imagePath: map['poster_path'] != null ? map['poster_path'] : null,
      popularity: map['popularity'] != null ? map['popularity'] : null,
      releaseDate: map['release_date'] != null ? map['release_date'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'imagePath': imagePath,
      'popularity': popularity,
      'releaseDate': releaseDate,
    };
  }
}
