import 'package:country_info_app/shared/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Axiforma',
  colorScheme: ColorScheme.light(
      surface: Colors.white,
      primary: AppColor.gray900,
      secondary: AppColor.gray500,
      tertiary: AppColor.gray100),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Axiforma',
  colorScheme: ColorScheme.dark(
    surface: AppColor.darkBlue,
    primary: AppColor.gray100,
    secondary: AppColor.gray400,
    tertiary: Color(0x3398A2B3),
  ),
);
