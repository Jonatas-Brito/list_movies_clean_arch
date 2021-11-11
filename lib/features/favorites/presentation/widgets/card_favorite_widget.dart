import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class CardFavorite extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const CardFavorite({
    Key? key,
    required this.onTap,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          'http://image.tmdb.org/t/p/w500${movie.imagePath}',
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                height: size.height * .24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 7),
                      width: size.width * .4,
                      child: Text(
                        movie.title,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                        minRating: 5,
                        initialRating: movie.voteAverage / 2,
                        ignoreGestures: true,
                        itemCount: 5,
                        glowColor: Colors.amber.shade600,
                        unratedColor: AppColors.bastille,
                        glowRadius: 5,
                        itemSize: 30,
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber.shade600,
                            ),
                        onRatingUpdate: (rating) {
                          print('Rating: $rating');
                        }),
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Text("${movie.voteAverage}"),
                    ),
                    SizedBox(height: 3),
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: SizedBox(
                          width: size.width * .4,
                          height: size.height * .06,
                          child: Text("${movie.overview}")),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: onTap,
                        child: Text(
                          '''Toque para continuar \nlendo''',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
