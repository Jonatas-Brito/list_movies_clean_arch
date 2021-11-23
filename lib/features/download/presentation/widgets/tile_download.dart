import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/images/app_images.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/api_string_images.dart';
import '../../../../core/utils/open_modal_details.dart';
import '../../../home/domain/entities/movie.dart';
import 'modal_downlaod_infos.dart';

class TileDownload extends StatefulWidget {
  final Movie movie;
  const TileDownload({Key? key, required this.movie}) : super(key: key);

  @override
  _TileDownloadState createState() => _TileDownloadState();
}

class _TileDownloadState extends State<TileDownload> {
  Movie movie = Movie.empty();
  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: size.height * .121,
        color: Colors.white10,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: ApiStringImage().originalImage(movie.bannerPath),
                  height: size.height * .124,
                  width: size.width * .45,
                  placeholder: (context, message) {
                    return Container(
                      width: size.width * .45,
                      height: size.height * .124,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 70, vertical: 31),
                        child: Container(
                            width: 35,
                            height: 35,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 3,
                            )),
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: size.height * .010,
                  left: size.width * .020,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 30,
                    width: 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.white54,
                          value: 0,
                        ),
                        Icon(
                          Icons.arrow_downward_rounded,
                          color: AppColors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 8),
              child: Container(
                  width: size.width * .52,
                  height: size.height * .113,
                  child: Stack(
                    children: [
                      titleMovie(movie.title),
                      Positioned(
                          right: size.width * .00,
                          bottom: size.height * .00,
                          child: GestureDetector(
                            onTap: () {
                              openBottomSheet(
                                  context: context,
                                  widget: ModalDownloadInfos(
                                    movie: movie,
                                  ));
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                AppImages.menu,
                                color: AppColors.white,
                              ),
                            ),
                          ))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleMovie(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.subtitle2!.copyWith(
            fontSize: 15,
            color: AppColors.white,
          ),
    );
  }
}
