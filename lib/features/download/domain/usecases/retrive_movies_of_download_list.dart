import 'package:movies_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/download/domain/repositories/download_repository.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

typedef ThisRetriveUseCase = UseCase<List<Movie>, NoParams>;

class RetriveMoviesForDownload implements ThisRetriveUseCase {
  final MoviesDownloadRepository downloadRepository;
  const RetriveMoviesForDownload({required this.downloadRepository});
  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await downloadRepository.retriveMoviesForDownload();
  }
}
