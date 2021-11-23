import 'package:flutter/material.dart';

import 'core/themes/app_colors.dart';
import 'features/download/presentation/pages/download_page.dart';
import 'features/favorites/presentation/pages/favorites_page.dart';
import 'features/home/presentation/pages/home.dart';
import 'features/home/presentation/widgets/page_in_construction.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    Key? key,
  }) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late PageController pageController;
  int selectedIndex = 0;

  List<Widget> pages = [
    HomePage(),
    MoviesFavoritesPage(),
    DownloadPage(),
    PageInConstruction(page: 2)
  ];

  List<IconData> iconPages = [];
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  Widget setIconAndIndex({required int index, required IconData icon}) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(icon, size: 32, color: colorIndex(index)),
      onPressed: () {
        // pageController.jumpToPage(index);

        pageController.animateToPage(index,
            duration: Duration(milliseconds: 700),
            curve: Curves.fastLinearToSlowEaseIn);
        setState(() => selectedIndex = index);
      },
    );
  }

  Color colorIndex(int index) {
    Color color = AppColors.bastille;
    if (index == selectedIndex) color = Colors.cyan.shade50;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (page) => selectedIndex = page,
            children: pages,
          ),
          AnimatedBuilder(
              animation: pageController,
              builder: (context, _) {
                return Positioned(
                  bottom: 25,
                  left: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.95),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          setIconAndIndex(icon: Icons.home_filled, index: 0),
                          setIconAndIndex(icon: Icons.favorite, index: 1),
                          setIconAndIndex(
                              icon: Icons.download_rounded, index: 2),
                          setIconAndIndex(
                              icon: Icons.person_outline_rounded, index: 3),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
