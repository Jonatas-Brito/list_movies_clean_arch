import 'package:movies_list/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required int id,
    required String title,
    required String imagePath,
    required double popularity,
    required String releaseDate,
    required String overview,
    required int voteCount,
  }) : super(
          id: id,
          title: title,
          imagePath: imagePath,
          popularity: popularity,
          releaseDate: releaseDate,
          overview: overview,
          voteCount: voteCount,
        );

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
        id: map['id'] != null ? map['id'] : null,
        title: map['title'] != null ? map['title'] : null,
        imagePath: map['poster_path'] != null ? map['poster_path'] : null,
        popularity: map['popularity'] != null ? map['popularity'] : null,
        releaseDate: map['release_date'] != null ? map['release_date'] : null,
        overview: map['overview'] != null ? map["overview"] : null,
        voteCount: map['vote_count'] != null ? map['vote_count'] : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': imagePath,
      'popularity': popularity,
      'release_date': releaseDate,
      'overview': overview,
      'vote_count': voteCount
    };
  }
}
