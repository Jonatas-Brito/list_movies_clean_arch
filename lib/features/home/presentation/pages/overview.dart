import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/features/download/presentation/cubit/download_list_movies/cubit/download_list_movies_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/api_string_images.dart';
import '../../../../core/utils/api_string_youtube.dart';
import '../../../../core/utils/release_data_converter.dart';
import '../../../../core/utils/show_message.dart';
import '../../../../main.dart';
import '../../../download/presentation/cubit/manager_download_list/manager_download_for_list_cubit.dart';
import '../../../favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../../../favorites/presentation/cubit/cubit/moviefavorites_cubit.dart';
import '../../domain/entities/cast_people.dart';
import '../../domain/entities/movie.dart';
import '../cubit/get_cast_people/get_cast_people_cubit.dart';
import '../cubit/movies_in_theaters/movies_in_theaters_cubit.dart';
import '../cubit/movies_popular/movies_popular_cubit.dart';
import '../widgets/favorite_button.dart';
import '../widgets/rating_bar.dart';

class OverviewPage extends StatefulWidget {
  final Movie movie;
  const OverviewPage({Key? key, required this.movie}) : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool popIsFavorite = false;
  bool isFavorite = false;
  bool hasDownloaded = false;
  Movie movie = Movie.empty();

  @override
  void initState() {
    setVariables();

    super.initState();
  }

  setVariables() {
    movie = widget.movie;

    hasDownloaded =
        movie.hasDownloaded != null ? movie.hasDownloaded! : hasDownloaded;

    isFavorite = movie.isFavorite != null ? movie.isFavorite! : isFavorite;
  }

  executeBlocs() {
    context.read<MoviesFavoritesListCubit>().getListFavorites();
    context.read<MoviesPopularCubit>().getListPopularMovies();
    context.read<MoviesInTheatersCubit>().getListMoviesInTheaters();
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;
    return BlocBuilder<ManagerFavoritesMoviesCubit,
        ManagerFavoritesMoviesState>(
      bloc: context.read<ManagerFavoritesMoviesCubit>(),
      builder: (context, state) {
        if (state is CachedToFavoritesSuccess) {
          context.read<MoviesFavoritesListCubit>().getListFavorites();
          isFavorite = state.movie.isFavorite!;
        }
        return Scaffold(
          backgroundColor: AppColors.woodsmoke,
          body: Column(
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: banner(),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: buttons(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    overviewText(movie),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buttons() {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      height: size.height * 0.17,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'toPo',
              onPressed: () async {
                context.read<MoviesFavoritesListCubit>().getListFavorites();
                await Future.delayed(Duration(milliseconds: 200));
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_rounded),
            ),
            FavoriteButton(
              isFavorite: isFavorite,
              onTap: () async {
                isFavorite
                    ? context
                        .read<ManagerFavoritesMoviesCubit>()
                        .removeMovieOfFavorites(movie)
                    : context
                        .read<ManagerFavoritesMoviesCubit>()
                        .addMovieToFavorites(movie);
                executeBlocs();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget textTitle({required Movie movie}) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double textScaleFactor = width / mockupWidth;
    return Container(
      width: size.width * .5,
      child: Text(
        movie.title,
        textScaleFactor: textScaleFactor,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontSize: 25,
              color: Colors.white,
            ),
      ),
    );
  }

  Widget overviewText(Movie movie) {
    bool trailerIdExist = movie.trailerId.isNotEmpty;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double textScaleFactor = width / mockupWidth;
    return Container(
      height: size.height * 0.38,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        children: [
          SizedBox(height: 10),
          textTitle(movie: movie),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateNumberToAbbreviationMonth(movie.releaseDate)),
              SizedBox(width: 5),
              RatingBarWidget(movie: movie)
            ],
          ),
          SizedBox(height: 10),
          // !trailerIdExist
          //     ? SizedBox()
          //     :
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.red)),
            onPressed: () => routeToYoutube(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  size: 35,
                ),
                Text(
                  AppStrings.watchTrailer,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          BlocBuilder<ManagerDownloadForListCubit, ManagerDownloadForListState>(
            bloc: context.read<ManagerDownloadForListCubit>(),
            builder: (context, state) {
              if (state is CacheOfDownloadListSuccess) {
                context.read<MoviesFavoritesListCubit>().getListFavorites();
                hasDownloaded = state.movie.hasDownloaded!;
              }
              return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.white)),
                onPressed: () => downloadMovie(),
                child: Text(
                  AppStrings.download,
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.woodsmoke,
                      ),
                ),
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            movie.overview,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          listCast(),
        ],
      ),
    );
  }

  Widget listCast() {
    Size size = MediaQuery.of(context).size;
    double screenHeigh = size.height - MediaQuery.of(context).padding.top;
    return Container(
      height: screenHeigh * .25,
      child: BlocBuilder<GetCastPeopleCubit, GetCastPeopleState>(
        bloc: context.read<GetCastPeopleCubit>(),
        builder: (context, state) {
          if (state is GetCastPeopleIsSuccessful) {
            movie.castPeople = state.listCast;
          }
          return ListView.builder(
            itemCount: movie.castPeople.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              CastPeople people = movie.castPeople[index];
              String pathImage = people.imagePath!;
              return people.imagePath!.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: size.height * .132,
                            width: size.width * .18,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: CachedNetworkImage(
                                imageUrl:
                                    ApiStringImage().originalImage(pathImage),
                                placeholder: (context, string) {
                                  return Container(
                                    height: size.height * .132,
                                    width: size.width * .18,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: size.height * .05,
                                      ),
                                      child: CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            width: size.width * .2,
                            child: Text(
                              people.name!,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }

  downloadMovie() {
    if (!hasDownloaded) {
      context.read<ManagerDownloadForListCubit>().addOfDownloadList(movie);
      context.read<DownloadListMoviesCubit>().retriveDownloadMovies();
      showScaffoldMessage(context,
          message: 'Adicionado a lista de download',
          color: AppColors.darkGreen);
    } else
      showScaffoldMessage(context,
          message: 'Este filme j?? est?? adicionado a lista de download',
          color: AppColors.equator);
    executeBlocs();
  }

  routeToYoutube() async {
    bool trailerIdExist = movie.trailerId.isNotEmpty;
    String trailerPath = widget.movie.trailerId;
    if (trailerIdExist) {
      String youtubeUrl = ApiStringYoutube().youtubePath(trailerPath);

      await launch(youtubeUrl);
    } else
      showScaffoldMessage(
        context,
        message: AppStrings.trailerNotDisponible,
        color: AppColors.equator,
      );
  }

  Widget banner() {
    Size size = MediaQuery.of(context).size;
    String bannerPath = widget.movie.bannerPath;

    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: ApiStringImage().originalImage(bannerPath),
          height: size.height * .6,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
