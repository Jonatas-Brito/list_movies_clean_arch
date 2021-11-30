import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/favorites/presentation/pages/favorites_page.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.home_filled,
                  size: 32,
                  color: Colors.white,
                )),
            IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => MoviesFavoritesPage()));
                },
                icon: Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.download_rounded,
                  size: 32,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.person_outline_rounded,
                  size: 32,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
