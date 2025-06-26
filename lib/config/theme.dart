import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.mainColor,
    secondary: AppColors.primaryColor,
  ),

  scaffoldBackgroundColor: AppColors.whiteColor,
  fontFamily: AppFonts.publicSansRegular,
  useMaterial3: false,
);
