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
  const OrderReportCard({
    super.key,
    required this.title,
    required this.stats,
    required this.forDelivered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color:
              forDelivered == true
                  ? AppColors.progressColor.withCustomOpacity(.5)
                  : AppColors.primaryColor.withCustomOpacity(.5),
        ),
        borderRadius: BorderRadius.circular(24),
        color:
            forDelivered == true
                ? AppColors.progressColor.withCustomOpacity(.2)
                : AppColors.primaryColor.withCustomOpacity(.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.regularStyle.copyWith(
              color:
                  forDelivered == true
                      ? AppColors.progressColor
                      : AppColors.primaryColor,
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
                  forDelivered == true
                      ? AppColors.progressColor
                      : AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
