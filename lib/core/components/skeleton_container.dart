import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const SkeletonContainer._({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
  }) : super(key: key);

  const SkeletonContainer.square({
    required double height,
    required double width,
    required BorderRadius borderRadius,
  }) : this._(width: width, height: height, borderRadius: borderRadius);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        curve: Curves.easeIn,
        gradientColor: Colors.white10,
        shimmerColor: Colors.white54,
        // gradientColor: AppColors.pink.withOpacity(0.1),
        // shimmerColor: AppColors.pink.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.bastille,
            borderRadius: borderRadius,
          ),
        ));
  }
}
