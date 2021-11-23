import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.purple,
    accentColor: AppColors.woodsmoke,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.white,
      selectionColor: AppColors.bastille,
      selectionHandleColor: AppColors.white,
    ),
    textTheme: GoogleFonts.montserratTextTheme()
        .apply(
          bodyColor: AppColors.white,
          displayColor: Colors.purple,
        )
        .copyWith(
          overline: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          bodyText1: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: AppColors.white),
          bodyText2: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white),
          button: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w200,
              color: AppColors.white),
          subtitle1:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
          subtitle2: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
  );
}
