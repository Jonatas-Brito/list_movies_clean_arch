class ApiStringsHome {
  String uriMovies(String path, String key) =>
      "https://api.themoviedb.org/3/movie/$path?api_key=$key&language=pt-BR&page=1";

  String uriTrailer(int id, String key) =>
      "https://api.themoviedb.org/3/movie/$id/videos?api_key=$key&language=en-US";

  String uriCast(int id, String key) =>
      "https://api.themoviedb.org/3/movie/$id/credits?api_key=$key&language=en-US";
}
