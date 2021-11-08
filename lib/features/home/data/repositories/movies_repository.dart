import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_remote_data_source.dart';

typedef _GetPopularOrInTheatersMovies = Future<List<Movie>> Function();

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const MoviesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  FutureGetMovies getMoviesInTheaters(
    String key,
  ) async {
    return await _getMovies(() {
      return remoteDataSource.getMoviesInTheaters(key);
    });
  }

  @override
  FutureGetMovies getMoviesPopular(
    String key,
  ) async {
    return await _getMovies(() {
      return remoteDataSource.getMoviesPopular(key);
    });
  }

  FutureGetMovies _getMovies(
      _GetPopularOrInTheatersMovies getPopularOrInTheaterMovies) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovies = await getPopularOrInTheaterMovies();
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(UnconnectedDevice());
  }
}
