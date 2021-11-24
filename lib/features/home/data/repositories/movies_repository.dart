import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/cast_people.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_remote_data_source.dart';

typedef FutureYoutubeId = Future<Either<Failure, String>>;

typedef _GetPopularOrInTheatersMovies = Future<List<Movie>> Function();
typedef _GetMovies = Future<List<Movie>> Function();
typedef _GetTrailerId = Future<String> Function();

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  const MoviesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});
  @override
  FutureGetMovies getMoviesInTheaters(
    String key,
  ) async {
    return await _getMovies(() => remoteDataSource.getMoviesInTheaters(key));
  }

  @override
  FutureGetMovies getMoviesPopular(
    String key,
  ) async {
    return await _getMovies(() => remoteDataSource.getMoviesPopular(key));
  }

  @override
  FutureYoutubeId getYoutubeId(
    int id,
    String key,
  ) async {
    return await _getTrailerId(() => remoteDataSource.getYoutubeId(id, key));
  }

  @override
  FutureGetMovies getCast(List<Movie> movies, String key) async {
    return await _getCast(() => remoteDataSource.getCastPeople(movies, key));
  }

  FutureGetMovies _getCast(_GetMovies getCastPeople) async {
    if (await networkInfo.isConnected) {
      try {
        final moviesWithCast = await getCastPeople();
        return Right(moviesWithCast);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(UnconnectedDevice());
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

  FutureYoutubeId _getTrailerId(_GetTrailerId getTrailerId) async {
    if (await networkInfo.isConnected) {
      try {
        final moviesWithTrailerId = await getTrailerId();
        return Right(moviesWithTrailerId);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(UnconnectedDevice());
  }
}
