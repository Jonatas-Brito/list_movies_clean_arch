import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';

class PageInConstructio extends StatelessWidget {
  final int page;
  const PageInConstructio({Key? key, this.page = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.woodsmoke,
      alignment: Alignment.center,
      child: Text('Tela $page em construcão!'),
    );
  }
}
