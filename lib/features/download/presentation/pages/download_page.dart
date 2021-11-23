import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../home/domain/entities/movie.dart';
import '../cubit/download_list_movies/cubit/download_list_movies_cubit.dart';
import '../widgets/tile_download.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  List<Movie> downloadMovies = [];

  @override
  void initState() {
    initBloc();
    super.initState();
  }

  initBloc() {
    context.read<DownloadListMoviesCubit>().retriveDownloadMovies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.woodsmoke,
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(
          'Downloads',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: 17,
                color: AppColors.white,
              ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.woodsmoke,
      ),
      body: BlocBuilder(
          bloc: context.read<DownloadListMoviesCubit>(),
          builder: (context, state) {
            if (state is GetDownloadListIsSuccess) {
              downloadMovies = state.downloadList;
              print('Tamanho: ${state.downloadList.length}');
              return Container(
                child: ListView.builder(
                    itemCount: downloadMovies.length,
                    itemBuilder: (context, index) {
                      Movie movie = downloadMovies[index];
                      return TileDownload(
                        movie: movie,
                      );
                    }),
              );
            }
            return SizedBox();
          }),
    );
  }
}
