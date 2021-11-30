import 'package:equatable/equatable.dart';

import '../../../../home/domain/entities/movie.dart';

class FavoriteParams extends Equatable {
  final Movie movie;
  const FavoriteParams({required this.movie});

  @override
  List<Object?> get props => [movie];
}
