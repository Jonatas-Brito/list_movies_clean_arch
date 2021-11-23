part of 'download_list_movies_cubit.dart';

abstract class DownloadListMoviesState extends Equatable {
  const DownloadListMoviesState();

  @override
  List<Object> get props => [];
}

class DownloadListMoviesInitial extends DownloadListMoviesState {}

class GetDownloadListIsSuccess extends DownloadListMoviesState {
  final List<Movie> downloadList;
  const GetDownloadListIsSuccess({required this.downloadList});
}

class GetDownloadListIsError extends DownloadListMoviesState {
  final String errorMessage;
  const GetDownloadListIsError({required this.errorMessage});
}

class GetDownloadListIsEmpty extends DownloadListMoviesState {
  final String message;
  const GetDownloadListIsEmpty(
      {this.message = 'Faça o download de um filme e ele aparecerá aqui'});
}

class GetDownloadListIsLoading extends DownloadListMoviesState {}
