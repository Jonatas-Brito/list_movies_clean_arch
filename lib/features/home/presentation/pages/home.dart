import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/utils/show_message.dart';
import 'package:movies_list/features/home/presentation/widgets/model_detais.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../main.dart';
import '../../../favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../../domain/entities/movie.dart';
import '../components/app_bar.dart';
import '../components/movie_card.dart';
import '../cubit/movies_in_theaters_cubit.dart';
import '../cubit/movies_popular_cubit.dart';
import 'home_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> moviesFavorite = [];
  bool loadingTheaterMovies = false;
  bool loadingPopularMovies = false;

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
    return Scaffold(
      appBar: MoviesAppBar(),
      backgroundColor: AppColors.woodsmoke,
      body: BlocBuilder<MoviesPopularCubit, MoviePopularState>(
        bloc: context.watch<MoviesPopularCubit>(),
        builder: (context, state) {
          if (state is GetPopularMoviesIsLoading) loadingPopularMovies = true;
          if (state is GetPopularMoviesIsError) {
            loadingPopularMovies = false;
            showErrorMessage(errorMessage: state.errorMessage);
          }
          if (state is GetPopularMoviesIsSuccessful)
            loadingPopularMovies = false;

          return BlocBuilder<MoviesInTheatersCubit, MoviesInTheatersState>(
              bloc: context.watch<MoviesInTheatersCubit>(),
              builder: (context, state) {
                if (state is GetMoviesInTheatersIsLoading)
                  loadingTheaterMovies = true;
                if (state is GetMoviesInTheatersIsError) {
                  loadingTheaterMovies = false;
                  showErrorMessage(errorMessage: state.errorMessage);
                }
                if (state is GetMoviesInTheatersIsSuccessful)
                  loadingTheaterMovies = false;
                if (loadingTheaterMovies && loadingPopularMovies) {
                  return HomeSkeleton();
                } else {
                  return buildListMovies();
                }
              });
        },
      ),
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
              title('Mais populares'),
              BlocBuilder<MoviesPopularCubit, MoviePopularState>(
                  bloc: context.watch<MoviesPopularCubit>(),
                  builder: (context, state) {
                    if (state is GetPopularMoviesIsSuccessful) {
                      return Column(
                        children: [
                          popularList(state.movies),
                        ],
                      );
                    }

                    return SizedBox(height: 150);
                  }),
              title('Assistir nos cinemas'),
              BlocBuilder<MoviesInTheatersCubit, MoviesInTheatersState>(
                  bloc: context.watch<MoviesInTheatersCubit>(),
                  builder: (context, state) {
                    if (state is GetMoviesInTheatersIsSuccessful) {
                      return Column(
                        children: [
                          inTheaterList(state.movies),
                        ],
                      );
                    }

                    return SizedBox(height: 150);
                  }),
              BlocBuilder<MoviesFavoritesListCubit, MoviesFavoritesListState>(
                bloc: context.watch<MoviesFavoritesListCubit>(),
                builder: (context, state) {
                  if (state is GetMoviesFavoritesIsSuccessful) {
                    print("Tamanho: ${state.movies.length}");
                    moviesFavorite = state.movies;
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

  Movie checkMovieInFavorites(Movie selectedMovie) {
    Movie movieSelected = Movie.empty();
    movieSelected = selectedMovie;
    // print("Tamanho: ${moviesFavorite.length}");
    moviesFavorite.forEach((movie) {
      bool equalsId = movie.id == movieSelected.id;
      if (equalsId) {
        movieSelected = movie;
      }
    });

    print("Is favorite: ${movieSelected.isFavorite}");

    return movieSelected;
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
              onTap: () => openBottomSheet(checkMovieInFavorites(movie)),
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
              onTap: () => openBottomSheet(checkMovieInFavorites(movie)),
            );
          }),
    );
  }

  openBottomSheet(Movie movie) {
    showModalBottomSheet(
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: AppColors.bastille,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        elevation: 0,
        builder: (context) {
          return ModalDetais(
            movie: movie,
          );
        });
  }
}
