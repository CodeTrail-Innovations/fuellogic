import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class OrderReportCard extends StatelessWidget {
  final String title;
  final String stats;
  final bool forDelivered;
  final bool forTruck;
  final VoidCallback? ontap;
  final String image;
  final bool isSvg;

  const OrderReportCard({
    super.key,
    required this.title,
    required this.stats,
    this.forDelivered = false,
    this.ontap,
    this.forTruck = false,
    required this.image,
    this.isSvg = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        forTruck == true
            ? AppColors.primaryColor
            : forDelivered == true
            ? AppColors.progressColor
            : AppColors.mainColor;

    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color:
                forTruck == true
                    ? AppColors.primaryColor.withCustomOpacity(.5)
                    : forDelivered == true
                    ? AppColors.progressColor.withCustomOpacity(.5)
                    : AppColors.mainColor.withCustomOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(24),
          color:
              forTruck == true
                  ? AppColors.primaryColor.withCustomOpacity(.2)
                  : forDelivered == true
                  ? AppColors.progressColor.withCustomOpacity(.2)
                  : AppColors.mainColor.withCustomOpacity(.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.regularStyle.copyWith(color: iconColor),
            ),
            16.vertical,
            Row(
              spacing: 24,
              children: [
                Text(stats, style: AppTextStyles.extraLargeStyle),

                isSvg
                    ? SvgPicture.asset(
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      image,
                      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                    )
                    : Image.asset(
                      image,
                      color: iconColor,
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
