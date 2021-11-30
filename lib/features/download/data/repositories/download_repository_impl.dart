import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/features/download/data/datasource/movies_for_download_datasource.dart';
import 'package:movies_list/features/download/domain/repositories/download_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class MoviesDownloadRepositoryImpl implements MoviesDownloadRepository {
  final DownloadListLocalDataSource downloadListLocalDataSource;
  const MoviesDownloadRepositoryImpl(
      {required this.downloadListLocalDataSource});
  @override
  Future<Either<Failure, Movie>> addMoviesForDownload(Movie movie) async {
    try {
      Movie movieReturned =
          await downloadListLocalDataSource.addMoviesForDownload(movie);
      return Right(movieReturned);
    } catch (e) {
      throw Left(CachedToAddFailure());
    }
  }

  @override
  Future<Either<Failure, Movie>> removeMoviesForDownload(Movie movie) async {
    try {
      Movie movieReturned =
          await downloadListLocalDataSource.removeMoviesForDownload(movie);
      return Right(movieReturned);
    } catch (e) {
      throw Left(CachedToAddFailure());
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> retriveMoviesForDownload() async {
    List<Movie> moviesForDownload = [];
    try {
      moviesForDownload =
          await downloadListLocalDataSource.retriveMoviesForDownload();
      return Right(moviesForDownload);
    } catch (e) {
      throw Left(CachedToAddFailure());
    }
  }
}
