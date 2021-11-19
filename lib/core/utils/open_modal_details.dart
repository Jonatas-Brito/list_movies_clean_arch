import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/core/utils/check_favorite_list.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/presentation/widgets/modal_detail.dart';

openBottomSheet(
    {required BuildContext context,
    required Movie movie,
    required List<Movie> favoriteMovies}) {
  checkMovieInFavorites(selectedMovie: movie, favoriteMovies: favoriteMovies);
  showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: AppColors.bastille,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      elevation: 0,
      builder: (context) {
        return ModalDetail(
          movie: movie,
        );
      });
}
