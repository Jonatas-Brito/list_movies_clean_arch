import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/home/data/datasources/movies_remote_data_source.dart';
import 'features/home/data/repositories/movies_repository.dart';
import 'features/home/domain/repositories/movies_repository.dart';
import 'features/home/domain/usecases/get_movies_in_theaters.dart';
import 'features/home/domain/usecases/get_popular_movies.dart';
import 'features/home/presentation/cubit/movie_cubit.dart';

// sl == Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Movie
  // Bloc
  sl.registerFactory(() => MoviePopularCubit(getPopularMovies: sl()));

  // User cases
  sl.registerSingleton(() => GetPopularMovies(sl()));
  sl.registerSingleton(() => GetMoviesInTeathers(sl()));

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
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
