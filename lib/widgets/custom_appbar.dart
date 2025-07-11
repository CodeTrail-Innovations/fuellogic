import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final bool isSimple;
  final String? title;
  const CustomAppBar({
    super.key,
    this.height,
    this.isSimple = false,
    this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? 100);

  @override
  Widget build(BuildContext context) {
    if (isSimple) {
      return AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          title ?? 'Back',
          style: AppTextStyles.largeStyle.copyWith(
            fontSize: 18,
            color: AppColors.blackColor,
            fontFamily: AppFonts.publicSansSemiBold,
          ),
        ),
        iconTheme: const IconThemeData(),
        backgroundColor: AppColors.transparentColor,
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.transparentColor,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome!",
                  style: AppTextStyles.extraLargeStyle.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Fueling Made Easy",
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
