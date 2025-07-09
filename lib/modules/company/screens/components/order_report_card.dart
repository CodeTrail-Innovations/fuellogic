import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
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
  const OrderReportCard({
    super.key,
    required this.title,
    required this.stats,
    this.forDelivered = false,
    this.ontap,
    this.forTruck = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
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
              style: AppTextStyles.regularStyle.copyWith(
                color:
                    forTruck == true
                        ? AppColors.primaryColor
                        : forDelivered == true
                        ? AppColors.progressColor
                        : AppColors.mainColor,
              ),
            ),
            16.vertical,
            Row(
              spacing: 24,
              children: [
                Text(stats, style: AppTextStyles.extraLargeStyle),
                SvgPicture.asset(
                  forDelivered == true
                      ? AppAssets.orderIconFilled
                      : AppAssets.orderIconLinear,
                  colorFilter: ColorFilter.mode(
                    forTruck == true
                        ? AppColors.primaryColor
                        : forDelivered == true
                        ? AppColors.progressColor
                        : AppColors.mainColor,
                    BlendMode.srcIn,
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
