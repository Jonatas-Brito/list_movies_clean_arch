import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

Color verifyColorPrimaryToPercent(double percent) {
  Color color = AppColors.darkGreen;

  if (percent >= 0.6) {
    color = AppColors.darkGreen;
  }

  if (percent >= 0.35 && percent < 0.6) {
    color = AppColors.equator;
  }
  if (percent < 0.35) color = AppColors.red.withOpacity(0.8);
  return color;
}

Color verifyColorSecondaryToPercent(double percent) {
  Color color = AppColors.darkGreen.withOpacity(0.5);

  if (percent >= 0.6) {
    color = AppColors.darkGreen.withOpacity(0.5);
  }

  if (percent >= 0.35 && percent < 0.6) {
    color = AppColors.equator.withOpacity(0.5);
  }
  if (percent < 0.35) color = AppColors.red.withOpacity(0.5);
  return color;
}
