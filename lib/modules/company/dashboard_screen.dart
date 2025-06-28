import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your company stats",
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: OrderReportCard(
                    title: 'Delivered',
                    stats: '25',
                    forDelivered: true,
                  ),
                ),
                Expanded(
                  child: OrderReportCard(
                    title: 'On the way',
                    stats: '45',
                    forDelivered: false,
                  ),
                ),
              ],
            ),
            AppButton(
              text: "View report",
              onPressed: () {},
              isIconButton: true,
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }
}

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
