import 'package:flutter/material.dart';
import 'package:movies_list/features/favorites/presentation/components/animeted_icon.dart';

class FavoriteButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isFavorite;
  const FavoriteButton(
      {Key? key, required this.onTap, required this.isFavorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FloatingActionButton(
      heroTag: "ToFavorites",
      onPressed: null,
      child: IconAnimated(
        color: Colors.white,
        iconFull: Icons.favorite,
        isFavorite: isFavorite,
        iconOutline: Icons.favorite_outline_rounded,
        onTap: onTap,
        size: 30,
        sizeAnimation: true,
      ),
    );
  }
}
