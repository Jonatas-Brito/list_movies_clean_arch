import 'package:dartz/dartz.dart';
import 'package:movies_list/features/download/domain/repositories/download_repository.dart';
import 'package:movies_list/features/download/domain/usecases/params/download_params.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../home/domain/entities/movie.dart';

typedef ThisAddUsecase = UseCase<Movie, DownloadParams>;

class AddMovieToDownload implements ThisAddUsecase {
  final MoviesDownloadRepository downloadReposiry;
  const AddMovieToDownload({required this.downloadReposiry});

  @override
  Future<Either<Failure, Movie>> call(DownloadParams params) async {
    return await downloadReposiry.addMoviesForDownload(params.movie);
  }
}
