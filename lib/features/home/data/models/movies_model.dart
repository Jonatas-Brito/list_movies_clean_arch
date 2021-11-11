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
    bool? isFavorite,
    required double? voteAverage,
    required String bannerPath,
  }) : super(
            id: id,
            title: title,
            imagePath: imagePath,
            voteAverage: voteAverage!,
            popularity: popularity,
            releaseDate: releaseDate,
            voteCount: voteCount,
            overview: overview,
            bannerPath: bannerPath,
            isFavorite: isFavorite);

  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
        id: map['id'] != null ? map['id'] : null,
        title: map['title'] != null ? map['title'] : null,
        voteAverage: map['vote_average'] != null
            ? (map['vote_average'] as num).toDouble()
            : null,
        isFavorite: map['is_favorite'] != null ? map['is_favorite'] : false,
        bannerPath: map['backdrop_path'] != null ? map['backdrop_path'] : null,
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
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'backdrop_path': bannerPath,
      'overview': overview,
      'vote_count': voteCount
    };
  }
}
