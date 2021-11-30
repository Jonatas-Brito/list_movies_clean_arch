import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/download/domain/repositories/download_repository.dart';
import 'package:movies_list/features/download/domain/usecases/params/download_params.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef ThisRemoveUsecase = UseCase<Movie, DownloadParams>;

class RemoveMovieOfDownload implements ThisRemoveUsecase {
  final MoviesDownloadRepository downloadRepository;

  const RemoveMovieOfDownload({required this.downloadRepository});
  @override
  Future<Either<Failure, Movie>> call(DownloadParams params) async {
    return await downloadRepository.removeMoviesForDownload(params.movie);
  }
}
