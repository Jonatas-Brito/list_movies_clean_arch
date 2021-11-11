import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../../domain/entities/movie.dart';
import '../components/app_bar.dart';
import '../components/movie_card.dart';
import '../cubit/movies_in_theaters_cubit.dart';
import '../cubit/movies_popular_cubit.dart';
import '../widgets/navigation_bar.dart';
import 'overview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  List<Movie> moviesFavorite = [];
  @override
  void initState() {
    context.read<MoviesInTheatersCubit>().getListMoviesInTheaters();
    context.read<MoviesFavoritesListCubit>().getListFavorites();
    context.read<MoviesPopularCubit>().getListPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MoviesAppBar(),
        backgroundColor: AppColors.woodsmoke,
        body: Container(
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
                          print("popular movies success");
                          return popularList(state.movies);
                        }
                        if (state is GetPopularMoviesIsError) {}

                        return Container(
                          height: 150,
                        );
                      }),
                  title('Assista nos cinemas'),
                  BlocBuilder<MoviesInTheatersCubit, MoviesInTheatersState>(
                      bloc: context.watch<MoviesInTheatersCubit>(),
                      builder: (context, state) {
                        print(state.runtimeType);
                        if (state is GetMoviesInTheatersIsSuccessful) {
                          print("teather movies success");
                          return Column(
                            children: [
                              inTheaterList(state.movies),
                            ],
                          );
                        }

                        return Container(
                          height: 150,
                        );
                      }),
                  BlocListener<MoviesFavoritesListCubit,
                      MoviesFavoritesListState>(
                    bloc: context.watch<MoviesFavoritesListCubit>(),
                    listener: (context, state) {
                      if (state is GetMoviesFavoritesIsSuccessful) {
                        moviesFavorite = state.movies;
                        print("FavoritesHomeLenght: ${moviesFavorite.length}");
                      }
                    },
                    child: SizedBox(),
                  ),
                ],
              ),
              Positioned(left: 0, right: 0, bottom: 0, child: gradientLayer()),
              Positioned(
                bottom: size.height * .035,
                left: 24,
                right: 24,
                child: CustomNavigationBar(),
              )
            ],
          ),
        ));
  }

  Widget title(String tile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        tile,
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
    moviesFavorite.forEach((movie) {
      bool equalsId = movie.id == movieSelected.id;
      if (equalsId) {
        if (movie.isFavorite == true) {
          print("Sou veerdadeiro");
          movieSelected = movie;
        }
      }
    });

    return movieSelected;
  }

  Widget popularList(List<Movie> list) {
    return Container(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: 320,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              Movie movie = list[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => OverviewPage(
                                movie: checkMovieInFavorites(movie),
                              )));
                },
              );
            }),
      ),
    );
  }

  Widget inTheaterList(List<Movie> list) {
    return Container(
      height: 320,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Movie movie = list[index];

            return MovieCard(
              fontSizeTitle: 13,
              fontSizeSubtitle: 11,
              heigth: 200,
              width: 150,
              movie: movie,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OverviewPage(
                              movie: checkMovieInFavorites(movie),
                            )));
              },
            );
          }),
    );
  }

  Widget gradientLayer() {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: Colors.red,
          gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.45),
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ])),
    );
  }
}
