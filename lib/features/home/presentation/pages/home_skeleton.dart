import 'package:flutter/material.dart';
import 'package:movies_list/core/components/skeleton_container.dart';

class HomeSkeleton extends StatefulWidget {
  const HomeSkeleton({Key? key}) : super(key: key);

  @override
  _HomeSkeletonState createState() => _HomeSkeletonState();
}

class _HomeSkeletonState extends State<HomeSkeleton> {
  Widget titleSkeleton({bool secondText = false}) {
    Size size = MediaQuery.of(context).size;
    return SkeletonContainer.square(
        height: size.height * .03,
        width: secondText ? size.width * .48 : size.width * .38,
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }

  skeletonWidget({bool isMoviesInTheater = false}) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      height: isMoviesInTheater ? height * .35 : height * .39,
      width: width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonContainer.square(
                    height: isMoviesInTheater ? height * .2439 : height * .30,
                    width: isMoviesInTheater ? width * .365 : width * .43,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: titleSkeleton(),
          ),
          SizedBox(height: 12),
          skeletonWidget(),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: titleSkeleton(secondText: true),
          ),
          SizedBox(height: 12),
          skeletonWidget(isMoviesInTheater: true),
        ],
      ),
    );
  }
}
