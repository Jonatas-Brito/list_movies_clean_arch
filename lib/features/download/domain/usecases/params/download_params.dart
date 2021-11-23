import 'package:equatable/equatable.dart';

import '../../../../home/domain/entities/movie.dart';

class DownloadParams extends Equatable {
  final Movie movie;
  const DownloadParams({required this.movie});

  @override
  List<Object?> get props => [movie];
}
