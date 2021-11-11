import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    primaryColor: AppColors.purple,
    accentColor: AppColors.woodsmoke,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: GoogleFonts.montserratTextTheme()
        .apply(
          bodyColor: Colors.white,
          displayColor: Colors.purple,
        )
        .copyWith(
          overline: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
          bodyText1: GoogleFonts.montserrat(
              fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),
          bodyText2: GoogleFonts.montserrat(
              fontSize: 14, fontWeight: FontWeight.w300, color: Colors.white),
          button: GoogleFonts.montserrat(
              fontSize: 18, fontWeight: FontWeight.w200, color: Colors.white),
          subtitle1:
              GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500),
          subtitle2:
              GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
        ),
  );
}
