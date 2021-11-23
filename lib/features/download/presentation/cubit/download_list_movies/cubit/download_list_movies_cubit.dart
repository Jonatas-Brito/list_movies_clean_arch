import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_list/core/error/failure.dart';
import 'package:movies_list/core/strings/app_strings.dart';
import 'package:movies_list/core/usecases/usecases.dart';
import 'package:movies_list/features/download/domain/usecases/retrive_movies_of_download_list.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

part 'download_list_movies_state.dart';

class DownloadListMoviesCubit extends Cubit<DownloadListMoviesState> {
  final RetriveMoviesForDownload retriveMoviesForDownload;
  DownloadListMoviesCubit({required this.retriveMoviesForDownload})
      : super(DownloadListMoviesInitial());

  retriveDownloadMovies() async {
    NoParams params = NoParams();
    final failureOrSuccess = await retriveMoviesForDownload(params);
    _eitherSuccessOrErrorState(failureOrSuccess);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async {
    failureOrMovies.fold(
        (failure) => emit(GetDownloadListIsError(
            errorMessage: AppStrings.CACHED_RETRIVE_DOWNLOAD_LIST_IS_FAILURE)),
        (downloadList) {
      if (downloadList.isEmpty) {
        emit(GetDownloadListIsEmpty(message: AppStrings.thereNoFavorites));
      } else {
        print(downloadList.length);
        emit(GetDownloadListIsSuccess(downloadList: downloadList));
      }
    });
  }
}
