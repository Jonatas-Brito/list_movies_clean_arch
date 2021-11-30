class AppStrings {
  // Layout Strings
  static String get watchInTheaters => "Assistir nos cinemas";
  static String get watchTrailer => "Ver trailer";
  static String get download => "Baixar";
  static String get titleDownload => "Downloads";
  static String get mostPopular => "Mais populares";
  static String get mostLiked => "Mais curtidos";
  static String get moreInformation => "Mais informações";
  static String get cancelDownload => "Cancelar Download";
  static String get tapToContinueReading => 'Toque para continuar \nlendo';
  static String get trailerNotDisponible => 'Trailer indisponível no momento';
  static String get anErrorHasOccurred => 'Ops!\nOcorreu um erro';
  static String get thereNoFavorites =>
      'Adicione um filme aos favoritos e ele ficara disponivel aqui!';
  static String get thereNoDownloads =>
      'Adicione um filme a lista de downloads e ele ficara disponivel aqui!';

  // Cache Messages

  static const String CACHED_RETRIVE_FAVORITE_IS_FAILURE =
      'Ocorreu um erro ao listar filmes favoritos';

  static const String CACHED_TO_REMOVE_FAVORITE_FAILURE =
      'Erro ao remover dos favoritos';

  static const String CACHED_TO_ADD_FAVORITE_FAILURE =
      'Erro ao adicionar aos favoritos';

  static const String CACHED_RETRIVE_DOWNLOAD_LIST_IS_FAILURE =
      'Ocorreu um erro ao listar filmes para download';

  static const String CACHED_TO_REMOVE_DOWNLOAD_FAILURE =
      'Erro ao remover dos filmes para download';

  static const String CACHED_TO_ADD_DOWNLOAD_FAILURE =
      'Erro ao adicionar aos para download';

  // Server Message
  static const String SERVER_FAILURE_MESSAGE = 'Houve um problema no servidor';

  // Network Connection Message
  static const String NETWORK_FAILURE_MESSAGE =
      'É necessário se connectar a internet para listar os filmes';

  // Search Message
  static const String SEARCH_FAILURE_MESSAGE = 'Erro ao pesquisar filme';
}
