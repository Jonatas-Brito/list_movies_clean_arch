import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/home/data/datasources/movies_remote_data_source.dart';
import 'features/home/data/repositories/movies_repository.dart';
import 'features/home/domain/repositories/movies_repository.dart';
import 'features/home/domain/usecases/get_movies_in_theaters.dart';
import 'features/home/domain/usecases/get_popular_movies.dart';
import 'features/home/presentation/cubit/movies_in_theaters_cubit.dart';
import 'features/home/presentation/cubit/movies_popular_cubit.dart';

// sl == Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Movie
  // Bloc
  sl.registerFactory(() => MoviesPopularCubit(getPopularMovies: sl()));
  sl.registerFactory(() => MoviesInTheatersCubit(getMoviesInTheaters: sl()));

  // User cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetMoviesInTheaters(sl()));

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
}
