import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/presentation/components/tile_component.dart';
import 'package:movies_list/features/home/presentation/pages/overview.dart';

import '../../../../main.dart';

class ModalDetail extends StatefulWidget {
  final Movie movie;
  const ModalDetail({Key? key, required this.movie}) : super(key: key);

  @override
  _ModalDetailState createState() => _ModalDetailState();
}

class _ModalDetailState extends State<ModalDetail> {
  Movie movie = Movie.empty();

  @override
  void initState() {
    movie = widget.movie;

    print("ID TRAILER: ${widget.movie.trailerId.isEmpty}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double voteAverage = widget.movie.voteAverage;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double textScaleFactor = width / mockupWidth;
    print("Vote: $voteAverage");
    print(
        "Movie: ${widget.movie.title.length} - Vote ${widget.movie.voteAverage}");
    int titleLength = widget.movie.title.length;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * .32,
                height: height * .35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          'http://image.tmdb.org/t/p/original${movie.imagePath}',
                        )),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * .035),
                child: Container(
                  height: height * .35,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width * .575,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: width * .4,
                                  child: Text(
                                    movie.title,
                                    textScaleFactor: textScaleFactor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Icon(Icons.close_rounded),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height:
                                heightForTitleLength(titleLength, voteAverage),
                            width: width * .53,
                            child: ListView(
                              children: [
                                Text(
                                  movie.overview,
                                  textScaleFactor: textScaleFactor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15.5),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      if (voteAverage > 7.5) ...[
                        Positioned(
                          bottom: 5,
                          child: Container(
                            alignment: Alignment.center,
                            width: width * .40,
                            height: height * .035,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/icons/like.png',
                                  height: 17,
                                ),
                                Text(
                                  "Mais curtidos",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          TileComponent(
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

  double heightForTitleLength(int titleLength, double voteAverage) {
    Size size = MediaQuery.of(context).size;
    double height = 0.0;

    if (titleLength >= 30 && voteAverage >= 7.5)
      height = size.height * .18;
    else if (titleLength >= 30)
      height = size.height * .22;
    else if (titleLength >= 25 && voteAverage >= 7.5)
      height = size.height * .22;
    else if (titleLength >= 25)
      height = size.height * .25;
    else if (titleLength >= 16 && voteAverage >= 7.5)
      height = size.height * .24;
    else if (titleLength >= 16)
      height = size.height * .23;
    else if (titleLength >= 1 && voteAverage >= 7.5)
      height = size.height * .24;
    else if (titleLength >= 1) height = size.height * .28;

    return height;
  }
}
