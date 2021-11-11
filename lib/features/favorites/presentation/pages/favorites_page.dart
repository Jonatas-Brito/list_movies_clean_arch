import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../home/domain/entities/movie.dart';
import '../../../home/presentation/cubit/movies_popular_cubit.dart';
import '../../../home/presentation/pages/overview.dart';
import '../cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../widgets/card_favorite_widget.dart';

class MoviesFavoritesPage extends StatefulWidget {
  const MoviesFavoritesPage({Key? key}) : super(key: key);

  @override
  _MoviesFavoritesPageState createState() => _MoviesFavoritesPageState();
}

class _MoviesFavoritesPageState extends State<MoviesFavoritesPage> {
  List<Movie> movies = [];
  var homeContext;

  @override
  void initState() {
    context.read<MoviesFavoritesListCubit>().getListFavorites();
    super.initState();
  }

  Widget customDivider() {
    return Column(
      children: [
        Container(
          height: 0.5,
          color: Colors.grey.withOpacity(0.5),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.woodsmoke,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
                BlocBuilder<MoviesFavoritesListCubit, MoviesFavoritesListState>(
                    bloc: context.read<MoviesFavoritesListCubit>(),
                    builder: (context, state) {
                      if (state is GetMoviesFavoritesIsSuccessful) {
                        return buildFavorites(state.movies);
                      }
                      if (state is GetMoviesFavoritesReturnedListEmpy) {
                        return listIsEmpty();
                      }
                      if (state is GetPopularMoviesIsError) {}

                      return Container(
                        height: 150,
                      );
                    }),
          ),
        ));
  }

  Widget listIsEmpty() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * .8,
        child: Text(
          'Adicione um filme aos favoritos e ele ficara disponivel aqui!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildFavorites(List<Movie> movies) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
          return Column(
            children: [
              if (index == 0) ...[Container(height: 20)],
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  children: [
                    if (index > 0) ...[customDivider()],
                    CardFavorite(
                      movie: movie,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => OverviewPage(
                                    popIsFavorite: true, movie: movie)));
                      },
                    )
                  ],
                ),
              ),
              if (index == movies.length - 1) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: customDivider(),
                ),
                Container(height: 150)
              ],
            ],
          );
        });
  }

  Widget listFavorite(Movie movie, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        children: [
          if (index > 0) ...[customDivider()],
          CardFavorite(
            movie: movie,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          OverviewPage(popIsFavorite: true, movie: movie)));
            },
          )
        ],
      ),
    );
  }
}
