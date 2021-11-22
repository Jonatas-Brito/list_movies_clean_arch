import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/utils/check_favorite_list.dart';
import 'package:movies_list/core/utils/open_modal_details.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/navigation.dart';
import '../../../../core/utils/show_message.dart';
import '../../../../main.dart';
import '../../../favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../../../search/presenter/pages/search_page.dart';
import '../../domain/entities/movie.dart';
import '../components/app_bar.dart';
import '../components/movie_card.dart';
import '../cubit/get_cast_people/get_cast_people_cubit.dart';
import '../cubit/get_trailer_id/cubit/gettrailerid_cubit.dart';
import '../cubit/movies_in_theaters/movies_in_theaters_cubit.dart';
import '../cubit/movies_popular/movies_popular_cubit.dart';
import 'home_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> favoriteMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> inTheaterMovies = [];

  bool loadingTheaterMovies = false;
  bool loadingPopularMovies = false;
  bool isReady = false;
  @override
  void initState() {
    super.initState();
    executeBlocs();
  }

  executeBlocs() async {
    context.read<MoviesInTheatersCubit>().getListMoviesInTheaters();
    context.read<MoviesPopularCubit>().getListPopularMovies();
    await Future.delayed(Duration(milliseconds: 100));
    context.read<MoviesFavoritesListCubit>().getListFavorites();
  }

  showErrorMessage({String errorMessage = ''}) async {
    await Future.delayed(Duration(milliseconds: 100));
    showScaffoldMessage(context, message: errorMessage, color: AppColors.red);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesPopularCubit, MoviePopularState>(
      bloc: context.watch<MoviesPopularCubit>(),
      builder: (context, state) {
        if (state is GetPopularMoviesIsLoading) loadingPopularMovies = true;
        if (state is GetPopularMoviesIsError) {
          loadingPopularMovies = false;
          showErrorMessage(errorMessage: state.errorMessage);
        }
        if (state is GetPopularMoviesIsSuccessful) {
          popularMovies = state.movies;
          loadingPopularMovies = false;
        }

        return BlocBuilder<MoviesInTheatersCubit, MoviesInTheatersState>(
          bloc: context.watch<MoviesInTheatersCubit>(),
          builder: (context, state) {
            if (state is GetMoviesInTheatersIsLoading)
              loadingTheaterMovies = true;
            if (state is GetMoviesInTheatersIsError) {
              loadingTheaterMovies = false;
              showErrorMessage(errorMessage: state.errorMessage);
            }
            if (state is GetMoviesInTheatersIsSuccessful) {
              loadingTheaterMovies = false;
              inTheaterMovies = state.movies;
            }
            isReady = loadingTheaterMovies && loadingPopularMovies;
            return Scaffold(
              appBar: MoviesAppBar(
                onTapIcon: !isReady
                    ? () => createRoute(context,
                        builder: SearchPage(movies: popularMovies))
                    : null,
              ),
              backgroundColor: AppColors.woodsmoke,
              body: isReady ? HomeSkeleton() : buildListMovies(),
            );
          },
        );
      },
    );
  }

  Widget buildListMovies() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        children: [
          ListView(
            children: [
              title(AppStrings.mostPopular),
              popularList(popularMovies),
              title(AppStrings.watchInTheaters),
              inTheaterList(inTheaterMovies),
              BlocBuilder<MoviesFavoritesListCubit, MoviesFavoritesListState>(
                bloc: context.watch<MoviesFavoritesListCubit>(),
                builder: (context, state) {
                  if (state is GetMoviesFavoritesIsSuccessful) {
                    print("Tamanho: ${state.movies.length}");
                    favoriteMovies = state.movies;
                  }
                  return SizedBox();
                },
              ),
              SizedBox(height: 45)
            ],
          ),
        ],
      ),
    );
  }

  Widget popularList(List<Movie> list) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      height: height * .39,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            Movie movie = list[index];
            return MovieCard(
              height: height * .30,
              width: width * .43,
              movie: movie,
              onTap: () {
                context.read<GetCastPeopleCubit>().getPeopleCast(
                    checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies));
                context.read<GetTrailerIdCubit>().getIdFromTrailer(
                    checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies));
                openBottomSheet(
                    context: context,
                    movie: checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies),
                    favoriteMovies: favoriteMovies);
                // openBottomSheet();
              },
            );
          }),
    );
  }

  Widget inTheaterList(List<Movie> list) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      height: height * .39,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Movie movie = list[index];

            return MovieCard(
              fontSizeTitle: 13,
              fontSizeSubtitle: 11,
              height: height * .2439,
              width: width * .365,
              movie: movie,
              onTap: () {
                context.read<GetCastPeopleCubit>().getPeopleCast(
                    checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies));
                context.read<GetTrailerIdCubit>().getIdFromTrailer(
                    checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies));
                openBottomSheet(
                    context: context,
                    movie: checkMovieInFavorites(
                        selectedMovie: movie, favoriteMovies: favoriteMovies),
                    favoriteMovies: favoriteMovies);
              },
            );
          }),
    );
  }

  Widget title(String tile) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double textScaleFactor = width / mockupWidth;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        tile,
        textScaleFactor: textScaleFactor,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
