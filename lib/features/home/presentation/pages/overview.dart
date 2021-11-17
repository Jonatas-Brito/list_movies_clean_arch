import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/core/utils/release_data_converter.dart';
import 'package:movies_list/core/utils/show_message.dart';
import 'package:movies_list/features/home/domain/entities/people_credits.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_in_theaters/movies_in_theaters_cubit.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_popular/movies_popular_cubit.dart';
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
    print("Is favorite: ${movie.trailerId}");

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
              fontSize: 18,
              color: Colors.white,
            ),
      ),
    );
  }

  Widget overviewText(Movie movie) {
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
              // Row(
              //   children: [
              //     Image.asset(
              //       'assets/icons/like.png',
              //       height: 17,
              //     ),
              //     SizedBox(width: 5),
              //     Text("${movie.voteAverage}")
              //   ],
              // ),
            ],
          ),
          SizedBox(height: 10),
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
                  'Ver trailer',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Text(
            movie.overview,
            textScaleFactor: textScaleFactor,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Container(
            height: size.height * .3,
            child: ListView.builder(
              itemCount: movie.castPeople.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CastPeople people = movie.castPeople[index];
                return people.imagePath!.isEmpty
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: size.width * .18,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://image.tmdb.org/t/p/original/${people.imagePath}',
                                  placeholder: (context, string) {
                                    return Container(
                                      height: size.height * .165,
                                      width: size.width * .18,
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
            ),
          )
        ],
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

    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl:
              'http://image.tmdb.org/t/p/original${widget.movie.bannerPath}',
          height: size.height * .6,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        // Positioned(
        //     left: 0,
        //     bottom: 0,
        //     child: RatingBarWidget(
        //       movie: widget.movie,
        //     ))
        // FloatingActionButton(
        //   child: Icon(
        //     Icons.play_arrow_rounded,
        //     size: 55,
        //   ),
        //   onPressed: () => routeToYoutube(),
        // ),
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
