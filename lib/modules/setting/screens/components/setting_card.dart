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
                  backgroundImage: NetworkImage(
                    "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
                  ),
                  radius: 32,
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
