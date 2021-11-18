import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/favorites/data/datasources/favorites_list_local_data_source.dart';
import 'features/favorites/data/repositories/movies_favorite_repository_impl.dart';
import 'features/favorites/domain/repositories/movies_favorite_repository.dart';
import 'features/favorites/domain/usecases/add_movie_to_favorites.dart';
import 'features/favorites/domain/usecases/remove_movie_of_favorites.dart';
import 'features/favorites/domain/usecases/retrive_movies_favorites.dart';
import 'features/favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import 'features/favorites/presentation/cubit/cubit/moviefavorites_cubit.dart';
import 'features/home/data/datasources/movies_remote_data_source.dart';
import 'features/home/data/repositories/movies_repository.dart';
import 'features/home/domain/repositories/movies_repository.dart';
import 'features/home/domain/usecases/get_cast.dart';
import 'features/home/domain/usecases/get_movies_in_theaters.dart';
import 'features/home/domain/usecases/get_popular_movies.dart';
import 'features/home/domain/usecases/get_youtube_id.dart';
import 'features/home/presentation/cubit/get_cast_people/get_cast_people_cubit.dart';
import 'features/home/presentation/cubit/get_trailer_id/cubit/gettrailerid_cubit.dart';
import 'features/home/presentation/cubit/movies_in_theaters/movies_in_theaters_cubit.dart';
import 'features/home/presentation/cubit/movies_popular/movies_popular_cubit.dart';
import 'features/search/domain/repositories/search_movies_repository.dart';
import 'features/search/domain/usecases/search_movie.dart';
import 'features/search/presenter/cubit/search/cubit/search_movie_cubit.dart';

// sl == Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Home
  // Bloc
  sl.registerFactory(() => MoviesPopularCubit(getPopularMovies: sl()));
  sl.registerFactory(() => MoviesInTheatersCubit(getMoviesInTheaters: sl()));
  sl.registerFactory(() => GetTrailerIdCubit(getTrailerId: sl()));
  sl.registerFactory(() => GetCastPeopleCubit(getCastPeople: sl()));

  // User cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetMoviesInTheaters(sl()));
  sl.registerLazySingleton(() => GetTrailerId(sl()));
  sl.registerLazySingleton(() => GetCastPeople(sl()));

  // Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  ///
  ///
  ///
  ///

  //! Feature - Favorites
  // Bloc
  sl.registerFactory(() => ManagerFavoritesMoviesCubit(
      addToFavorites: sl(), removeOfFavorites: sl()));
  sl.registerFactory(() => MoviesFavoritesListCubit(retriveMovies: sl()));

  // User cases
  sl.registerLazySingleton(() => AddMovieToFavorites(favoriteReposiry: sl()));
  sl.registerLazySingleton(
      () => RemoveMovieOfFavorites(favoriteReposiry: sl()));
  sl.registerLazySingleton(
      () => RetriveMoviesFavorites(favoriteReposiry: sl()));

  // Repository
  sl.registerLazySingleton<MoviesFavoriteReposiry>(
    () => MoviesFavoriteReposiryImpl(
      localFavoritesDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<FavoritesListLocalDataSource>(
      () => FavoritesListLocalDataSourceImpl(sharedPreferences: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  ///
  ///
  ///
  ///

  //! Feature - Search

  // Bloc
  sl.registerFactory(() => SearchMovieCubit(searchMovie: sl()));

  // User cases
  sl.registerLazySingleton(() => SearchMovie(sl()));

  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(),
  );
}
