import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/search/presenter/widgets/field_typeahead.dart';

class SearchPage extends StatefulWidget {
  final List<Movie> movies;
  const SearchPage({Key? key, required this.movies}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    movies = widget.movies;
    super.initState();
  }

  List<Widget> mapListToChildren() {
    return widget.movies
        .map((movie) => Container(
              width: 20,
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        'http://image.tmdb.org/t/p/original${movie.imagePath}',
                      )),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ))
        .toList();
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Container(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  height: size.height * .06,
                  child: FieldSearchComponent(
                    movies: movies,
                  ),
                ),
                Positioned(
                  top: size.height * .08,
                  right: 0,
                  left: 0,
                  bottom: 5,
                  child: Container(
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
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
