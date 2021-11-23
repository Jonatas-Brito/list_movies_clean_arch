import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';

class TileDownloadInfos extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  const TileDownloadInfos({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * .065,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade50,
            ),
            SizedBox(width: 35),
            Text(
              text,
              style: Theme.of(context).textTheme.overline!.copyWith(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
