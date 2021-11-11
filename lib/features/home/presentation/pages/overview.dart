import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
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

  @override
  void initState() {
    isFavorite =
        widget.movie.isFavorite != null ? widget.movie.isFavorite! : isFavorite;

    popIsFavorite = widget.popIsFavorite;
    super.initState();
  }

  addToFavorite(BuildContext context, Movie movie) {}

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
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                child: banner(),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: gradientLayer(),
              ),
              Positioned(
                  bottom: size.height * 0.23,
                  left: 0,
                  right: 0,
                  child: gradientLayer2()),
              Positioned(
                bottom: 0,
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
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios_rounded),
                        ),
                        popIsFavorite
                            ? SizedBox()
                            : FavoriteButton(
                                isFavorite: isFavorite,
                                onTap: () {
                                  isFavorite
                                      ? context
                                          .read<ManagerFavoritesMoviesCubit>()
                                          .removeMovieOfFavorites(movie)
                                      : context
                                          .read<ManagerFavoritesMoviesCubit>()
                                          .addMovieToFavorites(movie);
                                  context
                                      .read<MoviesFavoritesListCubit>()
                                      .getListFavorites();
                                },
                              )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget overviewText(Movie movie) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          movie.overview,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget banner() {
    Size size = MediaQuery.of(context).size;
    bool horizontalBanner;
    String setImage = "";
    if (size.width > 600) {
      setImage = widget.movie.bannerPath;
    } else
      setImage = widget.movie.imagePath;
    return
        // SizedBox();
        OverflowBox(
      maxWidth: 500,
      child: Transform.scale(
        scale: 0.8,
        child: Transform.translate(
          offset: Offset(0.0, -size.height * .240),
          child: CachedNetworkImage(
              imageUrl:
                  'http://image.tmdb.org/t/p/w500${widget.movie.imagePath}'),
        ),
      ),
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
      height: 500,
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
