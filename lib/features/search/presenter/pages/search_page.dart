import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_list/core/images/app_images.dart';
import 'package:movies_list/core/utils/check_favorite_list.dart';
import 'package:movies_list/core/utils/open_modal_details.dart';
import 'package:movies_list/features/favorites/presentation/cubit/cubit/cubit/moviesfavoriteslist_cubit.dart';
import 'package:movies_list/features/home/presentation/cubit/get_cast_people/get_cast_people_cubit.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/api_string_images.dart';
import '../../../home/domain/entities/movie.dart';
import '../cubit/search/cubit/search_movie_cubit.dart';
import '../widgets/text_field_widget.dart';

class SearchPage extends StatefulWidget {
  final List<Movie> movies;
  const SearchPage({Key? key, required this.movies}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> searchMovies = [];
  TextEditingController fieldController = TextEditingController();
  List<Movie> moviesList = [];
  List<Movie> favoriteMovies = [];
  bool loading = false;
  bool isEmpty = false;
  bool favoriteIsNotEmpty = false;

  @override
  void initState() {
    super.initState();
    moviesList = widget.movies;
  }

  List<Widget> mapListToChildren() {
    List<Movie> listMovies = [];

    if (searchMovies.isNotEmpty) {
      listMovies = searchMovies;
    } else
      listMovies = moviesList;
    return listMovies
        .map((movie) => GestureDetector(
              onTap: favoriteIsNotEmpty
                  ? () {
                      openBottomSheet(
                          context: context,
                          movie: checkMovieInFavorites(
                              selectedMovie: movie,
                              favoriteMovies: favoriteMovies),
                          favoriteMovies: favoriteMovies);
                    }
                  : null,
              child: Container(
                width: 20,
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ApiStringImage().originalImage(movie.imagePath),
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ))
        .toList();
  }

  Widget defineIcon(bool loading) {
    Widget icon = Icon(Icons.dangerous);
    if (loading) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: Container(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2.5,
          ),
        ),
      );
    } else if (loading == false) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: Container(
          height: 15,
          width: 15,
          child: SvgPicture.asset(
            AppImages.search,
            color: AppColors.white,
          ),
        ),
      );
    }
    if (isEmpty) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 20, top: 8, bottom: 8),
        child: InkWell(
          onTap: () {
            fieldController.clear();
            context.read<SearchMovieCubit>().searchInListMovies('', moviesList);
          },
          child: Container(
            height: 15,
            width: 15,
            child: Icon(
              Icons.close_rounded,
              color: AppColors.white,
            ),
          ),
        ),
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.woodsmoke,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: size.height * .08,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_rounded)),
        ),
        body: BlocBuilder<SearchMovieCubit, SearchMovieState>(
          bloc: context.read<SearchMovieCubit>(),
          builder: (context, state) {
            if (state is SearchMovieIsSuccess) {
              searchMovies = state.movies;
              loading = false;
              isEmpty = false;
            }

            if (state is SearchMovieIsLoading) {
              loading = true;
              isEmpty = false;
            }
            if (state is SearchMovieIsError) {
              isEmpty = false;
              loading = false;
            }
            if (state is SearchMovieIsEmpty) {
              isEmpty = true;
              loading = false;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Container(
                height: size.height,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * .06,
                      child: AppTextField(
                        icon: defineIcon(loading),
                        controller: fieldController,
                        onChanged: (text) {
                          print(text);
                          context
                              .read<SearchMovieCubit>()
                              .searchInListMovies(text, moviesList);
                        },
                      ),
                    ),
                    BlocBuilder<MoviesFavoritesListCubit,
                        MoviesFavoritesListState>(
                      bloc: context.read<MoviesFavoritesListCubit>(),
                      builder: (context, state) {
                        if (state is GetMoviesFavoritesIsSuccessful) {
                          favoriteIsNotEmpty = true;
                          favoriteMovies = state.movies;
                        }

                        return Positioned(
                          top: size.height * .08,
                          right: 0,
                          left: 0,
                          bottom: 5,
                          child: isEmpty ? isEmptyMessage() : gridView(),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget gridView() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.77,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 0.7,
          children: mapListToChildren(),
        ),
      ),
    );
  }

  Widget isEmptyMessage() {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(height: size.height * .03),
          Text(
            "Que pena... Não temos essa opção.",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: size.height * .01),
          Text(
            "Tente buscar por outro filme.",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(),
          ),
        ],
      ),
    );
  }
}
