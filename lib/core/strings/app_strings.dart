class AppStrings {
  // Layout Strings
  static String get watchInTheaters => "Assistir nos cinemas";
  static String get watchTrailer => "Ver trailer";
  static String get mostPopular => "Mais populares";
  static String get mostLiked => "Mais curtidos";
  static String get moreInformation => "Mais informações";
  static String get tapToContinueReading => 'Toque para continuar \nlendo';
  static String get trailerNotDisponible => 'Trailer indisponível no momento';
  static String get thereNoFavorites =>
      'Adicione um filme aos favoritos e ele ficara disponivel aqui!';

  // Cache Messages
  static const String CACHED_TO_REMOVE_FAILURE =
      'Erro ao remover dos favoritos';
  static const String CACHED_TO_ADD_FAILURE = 'Erro ao adicionar aos favoritos';

  // Server Message
  static const String SERVER_FAILURE_MESSAGE = 'Houve um problema no servidor';

  // Network Connection Message
  static const String NETWORK_FAILURE_MESSAGE =
      'É necessário se connectar a internet para listar os filmes';

  // Search Message
  static const String SEARCH_FAILURE_MESSAGE = 'Erro ao pesquisar filme';
}
