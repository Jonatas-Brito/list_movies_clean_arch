import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';
import 'package:movies_list/features/favorites/presentation/pages/favorites_page.dart';
import 'package:movies_list/features/home/presentation/pages/home.dart';
import 'package:movies_list/features/home/presentation/widgets/navigation_bar.dart';
import 'package:movies_list/features/home/presentation/widgets/page_in_construction.dart';

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
    PageInConstructio(),
    PageInConstructio(page: 2)
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

  Widget buildInConstruction() {
    return Container(
      color: AppColors.woodsmoke,
      alignment: Alignment.center,
      child: Text('Tela em construcão!'),
    );
  }

  Widget setIconAndIndex({required int index, required IconData icon}) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(icon, size: 32, color: colorIndex(index)),
      onPressed: () {
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
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.all(15),
      //   child: ClipRRect(
      //       borderRadius: BorderRadius.all(Radius.circular(50)),
      //       child: Container(
      //         color: Colors.black38,

      //         child: TabBar(
      //             unselectedLabelColor: Colors.white,
      //             controller: tabController,
      //             overlayColor: MaterialStateProperty.all(Colors.transparent),
      //             indicator: UnderlineTabIndicator(
      //               borderSide: BorderSide.none,
      //               insets: EdgeInsets.fromLTRB(
      //                 50.0,
      //                 0.0,
      //                 50.0,
      //                 5.0,
      //               ),
      //             ),
      //             onTap: (tab) {
      //               print(
      //                   "==================== Taaab: $tab ====================");
      //               setState(() => selectedIndex = tab);
      //             },
      //             tabs: [
      //               Tab(
      //                 icon: Icon(
      //                   Icons.home_filled,
      //                   size: 32,
      //                   color: colorIndex(0),
      //                 ),
      //               ),
      //               Tab(
      //                 icon: Icon(
      //                   Icons.favorite,
      //                   size: 30,
      //                   color: colorIndex(1),
      //                 ),
      //               ),
      //               Tab(
      //                 icon: Icon(
      //                   Icons.favorite,
      //                   size: 30,
      //                   color: colorIndex(2),
      //                 ),
      //               ),
      //               Tab(
      //                 icon: Icon(
      //                   Icons.person_outline_rounded,
      //                   size: 32,
      //                   color: colorIndex(3),
      //                 ),
      //               ),
      //             ]),
      //         //  BottomNavigationBar(
      //         //     backgroundColor: AppColors.red,
      //         //     currentIndex: tabController.page != null
      //         //         ? tabController.page!.round()
      //         //         : 0,
      //         //     onTap: (page) {
      //         //       tabController.animateToPage(page,
      //         //           duration: Duration(milliseconds: 600),
      //         //           curve: Curves.linearToEaseOut);
      //         //     },
      //         //     items: [
      //         //       BottomNavigationBarItem(
      //         //         icon: Icon(
      //         //           Icons.home_filled,
      //         //           size: 32,
      //         //           color: Colors.black,
      //         //         ),
      //         //         label: '',
      //         //       ),
      //         //       BottomNavigationBarItem(
      //         //         icon: Icon(
      //         //           Icons.favorite,
      //         //           size: 30,
      //         //           color: Colors.black,
      //         //         ),
      //         //         label: '',
      //         //       ),
      //         //       BottomNavigationBarItem(
      //         //         icon: Icon(
      //         //           Icons.download_rounded,
      //         //           size: 32,
      //         //           color: Colors.black,
      //         //         ),
      //         //         label: '',
      //         //       ),
      //         //       BottomNavigationBarItem(
      //         //         icon: Icon(
      //         //           Icons.person_outline_rounded,
      //         //           size: 32,
      //         //           color: Colors.black,
      //         //         ),
      //         //         label: '',
      //         //       ),
      //         //     ]),
      //       )),
      // ),
    );
  }
}
