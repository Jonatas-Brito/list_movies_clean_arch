class ApiStringImage {
  //  String get originalImage => _originalImage(path);

  String originalImage(String path) {
    return "http://image.tmdb.org/t/p/original/$path";
  }
}
