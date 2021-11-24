import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../home/domain/entities/movie.dart';
import '../../../home/presentation/cubit/get_cast_people/get_cast_people_cubit.dart';
import '../../../home/presentation/pages/overview.dart';
import '../cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import '../widgets/card_favorite_widget.dart';

class MoviesFavoritesPage extends StatefulWidget {
  const MoviesFavoritesPage({Key? key}) : super(key: key);

  @override
  _MoviesFavoritesPageState createState() => _MoviesFavoritesPageState();
}

class _MoviesFavoritesPageState extends State<MoviesFavoritesPage> {
  List<Movie> moviesFavorite = [];
  var homeContext;

  @override
  void initState() {
    super.initState();
    // checkFavorites();
  }

  checkFavorites() {
    if (moviesFavorite.isEmpty) {
      print('Estava vazia');
      context.read<MoviesFavoritesListCubit>().getListFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          title: Text(
            'Favoritos',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontSize: 17,
                  color: AppColors.white,
                ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.woodsmoke,
        ),
        backgroundColor: AppColors.woodsmoke,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
                BlocBuilder<MoviesFavoritesListCubit, MoviesFavoritesListState>(
                    bloc: context.read<MoviesFavoritesListCubit>(),
                    builder: (context, state) {
                      if (state is GetMoviesFavoritesIsSuccessful) {
                        moviesFavorite = state.movies;
                        return buildFavorites(moviesFavorite);
                      }
                      if (state is GetMoviesFavoritesReturnedListEmpy) {
                        return errorOrEmptyMessage(state.message);
                      }
                      if (state is GetMoviesFavoritesIsError) {
                        errorOrEmptyMessage(state.errorMessage);
                      }

                      return Container(height: 150);
                    }),
          ),
        ));
  }

  Widget buildFavorites(List<Movie> movies) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
          return Column(
            children: [
              if (index == 0) ...[Container(height: 20)],
              listFavorite(movie, index),
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
                      builder: (_) => OverviewPage(movie: movie)));
            },
          )
        ],
      ),
    );
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

  Widget errorOrEmptyMessage(String message) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * .335),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.grey.shade50),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
