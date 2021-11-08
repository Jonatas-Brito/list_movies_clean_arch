import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/presentation/components/app_bar.dart';
import 'package:movies_list/features/home/presentation/components/movie_card.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_in_theaters_cubit.dart';
import 'package:movies_list/features/home/presentation/cubit/movies_popular_cubit.dart';
import 'package:movies_list/features/home/presentation/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MoviesInTheatersCubit>().getListMoviesInTheaters();
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
                      bloc: context.read<MoviesPopularCubit>(),
                      builder: (context, state) {
                        if (state is GetPopularMoviesIsSuccessful) {
                          return popularList(state.movies);
                        }

                        return Container(
                          height: 150,
                        );
                      }),
                  title('Assista nos cinemas'),
                  BlocBuilder<MoviesInTheatersCubit, MoviesInTheatersState>(
                      bloc: context.read<MoviesInTheatersCubit>(),
                      builder: (context, state) {
                        if (state is GetMoviesInTheatersIsSuccessful) {
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
                  SizedBox(height: 150)
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

  Widget popularList(List<Movie> list) {
    print(list.length);
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
              Movie item = list[index];
              print(item.imagePath);
              return MovieCard(movie: item);
            }),
      ),
    );
  }

  Widget inTheaterList(List<Movie> list) {
    print(list.length);
    return Container(
      height: 320,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Movie item = list[index];

            return MovieCard(
              fontSizeTitle: 13,
              fontSizeSubtitle: 11,
              heigth: 200,
              width: 150,
              movie: item,
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
