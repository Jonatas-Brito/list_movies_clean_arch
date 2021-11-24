import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/strings/app_strings.dart';
import 'package:movies_list/core/utils/show_message.dart';

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
    return Scaffold(
      backgroundColor: AppColors.woodsmoke,
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(
          AppStrings.titleDownload,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: 17,
                color: AppColors.white,
              ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.woodsmoke,
      ),
      body: BlocBuilder<DownloadListMoviesCubit, DownloadListMoviesState>(
          bloc: context.watch<DownloadListMoviesCubit>(),
          builder: (context, state) {
            if (state is GetDownloadListIsSuccess) {
              downloadMovies = state.downloadList;
            }

            if (state is GetDownloadListIsEmpty) {
              return buildMessage(state.message);
            }
            if (state is GetDownloadListIsLoading) {
              return buildLoading();
            }

            if (state is GetDownloadListIsError) {
              showError(state.errorMessage);
              return buildMessage(AppStrings.anErrorHasOccurred);
            }

            return buildListDownloadMovie();
          }),
    );
  }

  Widget buildMessage(String message) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * .35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  showError(String message) async {
    await Future.delayed(Duration(milliseconds: 100));
    showScaffoldMessage(context, message: message, color: AppColors.red);
  }

  buildLoading() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height * .35,
        ),
        Container(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget buildListDownloadMovie() {
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
}
