import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static TextStyle headingStyle = TextStyle(
    fontSize: 36,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interBold,
  );
  static TextStyle paragraphItalicStyle = TextStyle(
    fontSize: 16,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interMediumItalic,
  );
  static TextStyle labelStyle = TextStyle(
    fontSize: 18,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interSemiBold,
  );
  static TextStyle? regularStyle = TextStyle(
    fontSize: 14,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interMedium,
  );
  static TextStyle heading1Style = TextStyle(
    fontSize: 30,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interSemiBold,
  );

  static TextStyle heading2Style = TextStyle(
    fontSize: 30,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interBold,
  );
  static TextStyle paragraphStyle = TextStyle(
    fontSize: 16,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interRegular,
  );
  static TextStyle captionStyle = TextStyle(
    fontSize: 12,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interMedium,
  );
  static TextStyle paragraphBoldStyle = TextStyle(
    fontSize: 16,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interSemiBold,
  );
  static TextStyle smallTextStyle = TextStyle(
    fontSize: 10,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interSemiBold,
  );
  static TextStyle smallText1Style = TextStyle(
    fontSize: 8,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interRegular,
  );
  static TextStyle captionBold = TextStyle(
    fontSize: 12,
    color: AppColors.blackColor,
    fontFamily: AppFonts.interBold,
  );


  static const tableHeaderStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const tableCellStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  static const tagStyle = TextStyle(
    fontSize: 10,
    color: Colors.black87,
  );
}
