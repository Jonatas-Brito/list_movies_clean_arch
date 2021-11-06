import 'dart:convert';

class Movie {
  String? title;
  String? imagePath;
  double? popularity;
  String? releaseDate;

  Movie({
    this.title,
    this.imagePath,
    this.popularity,
    this.releaseDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'popularity': popularity,
      'releaseDate': releaseDate,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] != null ? map['original_title'] : null,
      imagePath: map['imagePath'] != null ? map['poster_path'] : null,
      popularity: map['popularity'] != null ? map['popularity'] : null,
      releaseDate: map['releaseDate'] != null ? map['release_date'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
