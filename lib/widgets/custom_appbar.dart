import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  const CustomAppBar({super.key, this.height});

  @override
  Size get preferredSize => Size.fromHeight(height ?? 100);

  @override
  Widget build(BuildContext context) {
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
                  "Good Morning 👋!",
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
            const CircleAvatar(radius: 20, child: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
