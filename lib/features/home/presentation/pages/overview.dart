import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/core/utils/show_message.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_in_theaters_cubit.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_popular_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../../../favorites/presentation/cubit/cubit/moviefavorites_cubit.dart';
import '../../domain/entities/movie.dart';
import '../widgets/favorite_button.dart';
import '../widgets/rating_bar.dart';

class OverviewPage extends StatefulWidget {
  final Movie movie;
  final bool popIsFavorite;
  const OverviewPage(
      {Key? key, required this.movie, this.popIsFavorite = false})
      : super(key: key);

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  bool popIsFavorite = false;
  bool isFavorite = false;
  Movie movie = Movie.empty();

  @override
  void initState() {
    movie = widget.movie;
    isFavorite =
        widget.movie.isFavorite != null ? widget.movie.isFavorite! : isFavorite;

    popIsFavorite = widget.popIsFavorite;
    super.initState();
  }

  executeBlocs() {
    context.read<MoviesFavoritesListCubit>().getListFavorites();
    context.read<MoviesPopularCubit>().getListPopularMovies();
    context.read<MoviesInTheatersCubit>().getListMoviesInTheaters();
  }

  @override
  Widget build(BuildContext context) {
    Movie movie = widget.movie;
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ManagerFavoritesMoviesCubit,
        ManagerFavoritesMoviesState>(
      bloc: context.read<ManagerFavoritesMoviesCubit>(),
      builder: (context, state) {
        if (state is CachedToFavoritesSuccess) {
          context.read<MoviesFavoritesListCubit>().getListFavorites();
          isFavorite = state.movie.isFavorite!;
        }
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            height: size.height,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: banner(),
                ),
                // Positioned(
                //     top: size.height * .25,
                //     child: Icon(
                //       Icons.play_circle_outline_outlined,
                //       size: 55,
                //     )),
                // Positioned(
                //   bottom: 0,
                //   left: 0,
                //   right: 0,
                //   child: gradientLayer(),
                // ),
                // Positioned(
                //     bottom: size.height * 0.23,
                //     left: 0,
                //     right: 0,
                //     child: gradientLayer2()),
                Positioned(
                  bottom: 00,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      RatingBarWidget(movie: movie),
                      overviewText(movie),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
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
                              context
                                  .read<MoviesFavoritesListCubit>()
                                  .getListFavorites();
                              await Future.delayed(Duration(milliseconds: 200));
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios_rounded),
                          ),
                          popIsFavorite
                              ? SizedBox()
                              : FavoriteButton(
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
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget overviewText(Movie movie) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double textScaleFactor = width / mockupWidth;
    return Container(
      height: size.height * 0.33,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          movie.overview,
          textScaleFactor: textScaleFactor,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  routeToYoutube() async {
    bool trailerIdExist = movie.trailerId.isNotEmpty;
    if (trailerIdExist) {
      final youtubeUrl =
          'https://www.youtube.com/embed/${widget.movie.trailerId}';

      await launch(youtubeUrl);
    } else
      showScaffoldMessage(context,
          message: 'Não temos um link para este trailer',
          color: AppColors.equator);
  }

  Widget banner() {
    Size size = MediaQuery.of(context).size;
    String setImage = "";
    if (size.width > 600) {
      setImage = widget.movie.bannerPath;
    } else
      setImage = widget.movie.imagePath;
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
            imageUrl:
                'http://image.tmdb.org/t/p/original${widget.movie.bannerPath}',
            height: size.height * .6,
            width: double.infinity,
            fit: BoxFit.cover),
        GestureDetector(
          onTap: () {
            routeToYoutube();
          },
          child: Container(
            height: 60,
            width: 60,
            child: Image.asset('assets/icons/play1.png'),
          ),
        ),
      ],
    );
  }

  Widget gradientLayer2() {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.15,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
          ])),
    );
  }

  Widget gradientLayer() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.1),
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.7),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.8),
          ])),
    );
  }
}
