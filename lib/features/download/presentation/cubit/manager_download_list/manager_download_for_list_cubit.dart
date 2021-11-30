import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/app_strings.dart';
import '../../../../home/domain/entities/movie.dart';
import '../../../domain/usecases/add_movie_to_download_list.dart';
import '../../../domain/usecases/params/download_params.dart';
import '../../../domain/usecases/remove_movie_of_download_list.dart';

part 'manager_download_for_list_state.dart';

class ManagerDownloadForListCubit extends Cubit<ManagerDownloadForListState> {
  final AddMovieToDownload addMovieToDownload;
  final RemoveMovieOfDownload removeMovieOfDownload;

  ManagerDownloadForListCubit({
    required this.addMovieToDownload,
    required this.removeMovieOfDownload,
  }) : super(ManagerDownloadForListInitial());

  addOfDownloadList(Movie movie) async {
    print("ADICIONANDO A DOWNLOADS");
    DownloadParams params = DownloadParams(movie: movie);
    final failureOrSuccess = await addMovieToDownload(params);
    _eitherSuccessOrErrorState(failureOrSuccess);
  }

  removeOfDownloadList(Movie movie) async {
    print("REMOVENDO DE DOWNLOADS");

    DownloadParams params = DownloadParams(movie: movie);
    final failureOrSuccess = await removeMovieOfDownload(params);
    _eitherSuccessOrErrorState(failureOrSuccess);
  }

  _eitherSuccessOrErrorState(
    Either<Failure, Movie> failureOrSuccess,
  ) async {
    failureOrSuccess.fold(
        (failure) => emit(CacheOfDownloadListFailure(
            errorMessage: _setFailureMessage(failure))), (movie) async {
      emit(CacheOfDownloadListSuccess(movie: movie));
      await Future.delayed(Duration(milliseconds: 100));
      emit(ManagerDownloadForListInitial());
    });
  }

  String _setFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CachedToAddFailure:
        return AppStrings.CACHED_TO_ADD_DOWNLOAD_FAILURE;
      case CachedToRemoveFailure:
        return AppStrings.CACHED_TO_REMOVE_DOWNLOAD_FAILURE;
      default:
    }
    return 'Erro inesperado';
  }
}
