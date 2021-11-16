import 'package:dartz/dartz.dart';
import 'package:movies_list/core/error/exceptions.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/network/network_info.dart';
import 'package:movies_list/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/domain/repositories/movies_repository.dart';
import 'package:movies_list/features/home/domain/usecases/get_youtube_id.dart';

typedef FutureYoutubeId = Future<Either<Failure, String>>;
typedef _GetPopularOrInTheatersMovies = Future<List<Movie>> Function();
// typedef _GetTrailerId = Future<String> Function();

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

  // @override
  // FutureYoutubeId getYoutubeId(
  //   int id,
  //   String key,
  // ) async {
  //   return await _getTrailerId(() => remoteDataSource.getYoutubeId(id, key));
  // }

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

  // FutureYoutubeId _getTrailerId(_GetTrailerId getTrailerId) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final trailerId = await getTrailerId();
  //       return Right(trailerId);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else
  //     return Left(UnconnectedDevice());
  // }
}
