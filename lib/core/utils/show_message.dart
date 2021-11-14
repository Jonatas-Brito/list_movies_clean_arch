import 'package:flutter/material.dart';

showScaffoldMessage(BuildContext context,
    {required String? message, required Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      content: Text(
        message!,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
      )));
}
