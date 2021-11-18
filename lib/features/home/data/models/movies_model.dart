import '../../domain/entities/movie.dart';
import 'people_credits_models.dart';

class MovieModel extends Movie {
  MovieModel({
    required int id,
    required String title,
    required String imagePath,
    required double popularity,
    required String releaseDate,
    required String overview,
    required int voteCount,
    required List<CastPeopleModel> castPeople,
    bool? isFavorite,
    required double? voteAverage,
    required String? trailerId,
    required String bannerPath,
  }) : super(
            id: id,
            trailerId: trailerId!,
            castPeople: castPeople,
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
        trailerId: map['trailer_id'] != null ? map['trailer_id'] : '',
        castPeople: map['known_for_department'] != null
            ? <CastPeopleModel>[]
            : <CastPeopleModel>[],
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
      'trailer_id': trailerId,
      'poster_path': imagePath,
      'known_for_department': castPeople,
      'popularity': popularity,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'backdrop_path': bannerPath,
      'overview': overview,
      'vote_count': voteCount
    };
  }
}
