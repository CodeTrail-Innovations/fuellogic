import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String? icon;
  final bool forIcon;
  final VoidCallback? onTap;
  const SettingCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.forIcon,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              forIcon == false
                  ? AppColors.greyColor.withCustomOpacity(.3)
                  : null,
        ),
        child: Row(
          spacing: 16,
          children: [
            forIcon == true
                ? SvgPicture.asset(
                  icon ?? AppAssets.legalIcon,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                )
                : CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(Icons.person, color: AppColors.whiteColor),
                ),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.regularStyle),
                Text(
                  subTitle,
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.mainColor.withCustomOpacity(.7),
                  ),
                ),
              ],
            ),
            Spacer(),
            SvgPicture.asset(AppAssets.arrowRightIcon),
          ],
        ),
      ),
    );
  }
}
