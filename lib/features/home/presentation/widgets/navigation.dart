import 'package:flutter/material.dart';
import 'package:movies_list/features/home/domain/entities/movie.dart';
import 'package:movies_list/features/home/presentation/widgets/navigation_bar.dart';

class Navigation extends StatelessWidget {
  final List<Movie> movies;
  const Navigation({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
