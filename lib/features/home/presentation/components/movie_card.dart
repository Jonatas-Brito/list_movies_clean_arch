import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/core/utils/release_data_converter.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

import 'animated_progress.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final double? width;
  final double? heigth;
  final double? fontSizeTitle;
  final double? fontSizeSubtitle;
  const MovieCard({
    Key? key,
    required this.movie,
    this.width = 180,
    this.heigth = 250,
    this.fontSizeTitle = 14,
    this.fontSizeSubtitle = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = movie.popularity / 10000;
    print("percent: $percent ");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: width,
            height: heigth,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      'http://image.tmdb.org/t/p/w500${movie.imagePath}',
                    )),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 35,
                    width: 35,
                    child: AnimatedProgress(
                      percent: percent,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                color: Colors.transparent,
                child: Text(
                  movie.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.bold, fontSize: fontSizeTitle),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                  width: width,
                  child: Text(
                    dateNumberToAbbreviationMonth(movie.releaseDate),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: fontSizeSubtitle),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
