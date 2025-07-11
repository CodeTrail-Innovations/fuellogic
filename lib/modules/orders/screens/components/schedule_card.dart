import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class ScheduleCard extends StatelessWidget {
  final String date;

  const ScheduleCard({super.key, required this.date});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withCustomOpacity(0.05),
            AppColors.primaryColor.withCustomOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withCustomOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              AppAssets.clockIcon,
              height: 20,
              width: 20,
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          16.horizontal,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scheduled Date & Time',
                  style: AppTextStyles.captionStyle.copyWith(
                    color: AppColors.blackColor.withCustomOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                4.vertical,
                Text(
                  date,
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
