import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_colors.dart';

class AppTextField extends StatefulWidget {
  final Widget icon;
  final Function(String)? onChanged;
  const AppTextField({Key? key, required this.icon, this.onChanged})
      : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  OutlineInputBorder defaultOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.white,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(),
      decoration: InputDecoration(
        border: defaultOutlineInputBorder(),
        enabledBorder: defaultOutlineInputBorder(),
        focusedBorder: defaultOutlineInputBorder(),
        hintText: 'Buscar',
        suffixIcon: widget.icon,
        contentPadding: EdgeInsets.only(
          top: 12,
          left: 8,
          bottom: 10,
          right: 8,
        ),
        hintStyle: GoogleFonts.montserrat(
          color: AppColors.white,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
      ),
    );
  }
}
