import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

openBottomSheet({required BuildContext context, required Widget widget}) {
  showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: AppColors.bastille,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      elevation: 0,
      builder: (context) {
        return widget;
      });
}
