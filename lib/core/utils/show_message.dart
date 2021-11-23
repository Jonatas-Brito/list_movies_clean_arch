import 'package:flutter/material.dart';
import 'package:movies_list/core/themes/app_colors.dart';

showScaffoldMessage(BuildContext context,
    {required String? message, required Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(
        message!,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
      )));
}
