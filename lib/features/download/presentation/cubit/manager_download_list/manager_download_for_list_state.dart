part of 'manager_download_for_list_cubit.dart';

abstract class ManagerDownloadForListState extends Equatable {
  const ManagerDownloadForListState();

  @override
  List<Object> get props => [];
}

class ManagerDownloadForListInitial extends ManagerDownloadForListState {}

class CacheOfDownloadListSuccess extends ManagerDownloadForListState {
  final Movie movie;
  const CacheOfDownloadListSuccess({required this.movie});
}

class CacheOfDownloadListFailure extends ManagerDownloadForListState {
  final String errorMessage;
  const CacheOfDownloadListFailure({required this.errorMessage});
}
