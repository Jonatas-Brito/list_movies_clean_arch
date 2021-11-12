import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';

class RatingBarWidget extends StatelessWidget {
  final Movie movie;
  const RatingBarWidget({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        RatingBar.builder(
            minRating: 5,
            initialRating: movie.voteAverage / 2,
            ignoreGestures: true,
            itemCount: 5,
            glowColor: Colors.amber.shade600,
            unratedColor: AppColors.bastille,
            glowRadius: 5,
            itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber.shade400,
                ),
            onRatingUpdate: (rating) {}),
        SizedBox(width: 4),
        Container(
          alignment: Alignment.bottomCenter,
          height: size.height * .04,
          child: Text(
            "${movie.voteAverage}",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}
