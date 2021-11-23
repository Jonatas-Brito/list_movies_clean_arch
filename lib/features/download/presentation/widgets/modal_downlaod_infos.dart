import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/features/download/presentation/cubit/download_list_movies/cubit/download_list_movies_cubit.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../home/domain/entities/movie.dart';
import '../cubit/manager_download_list/manager_download_for_list_cubit.dart';
import 'tile_download_infos.dart';

class ModalDownloadInfos extends StatefulWidget {
  final Movie movie;
  const ModalDownloadInfos({Key? key, required this.movie}) : super(key: key);

  @override
  _ModalDownloadInfosState createState() => _ModalDownloadInfosState();
}

class _ModalDownloadInfosState extends State<ModalDownloadInfos> {
  Movie movie = Movie.empty();
  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 35),
          titleMovie(movie.title),
          SizedBox(height: 65),
          TileDownloadInfos(
            onTap: () => removMovieOfDownloadList(movie),
            icon: Icons.file_download_off,
            text: AppStrings.cancelDownload,
          ),
          SizedBox(height: 5),
          TileDownloadInfos(
            onTap: () {
              //  openBottomSheet(
              //     context: context,
              //     widget: ModalDetail(
              //       movie: checkMovie(
              //           selectedMovie: movie, favoriteMovies: favoriteMovies),
              //     ),
              //   );
            },
            icon: Icons.info_outline,
            text: AppStrings.moreInformation,
          ),
          SizedBox(height: 35),
          //
        ],
      ),
    );
  }

  Widget titleMovie(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontSize: 15,
            color: AppColors.white,
          ),
    );
  }

  removMovieOfDownloadList(Movie movie) {
    context.read<ManagerDownloadForListCubit>().removeOfDownloadList(movie);
    context.read<DownloadListMoviesCubit>().retriveDownloadMovies();
    Navigator.pop(context);
  }
}
