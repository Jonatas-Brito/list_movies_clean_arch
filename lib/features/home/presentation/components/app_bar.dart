import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/images/app_images.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../main.dart';

class MoviesAppBar extends StatelessWidget with PreferredSizeWidget {
  final VoidCallback onTapIcon;
  const MoviesAppBar({required this.onTapIcon});

  @override
  Size get preferredSize => Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double textScaleFactor = width / mockupWidth;
    return Container(
      height: height * .145,
      color: AppColors.woodsmoke,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              left: 10,
              child: Text.rich(
                TextSpan(
                    text: 'Mov',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 42, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "ve",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: AppColors.red),
                      )
                    ]),
                textScaleFactor: textScaleFactor,
              )),
          Positioned(
              right: 10,
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: SvgPicture.asset(
                  AppImages.search,
                  color: AppColors.white,
                  height: 35,
                ),
                onPressed: onTapIcon,
              ))
        ],
      ),
    );
  }
}
