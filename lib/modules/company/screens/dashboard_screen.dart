import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/company/screens/components/order_report_card.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
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
            Text(
              "Recent Orders",
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            OrderCard(status: OrderStatus.pending),
            OrderCard(status: OrderStatus.approved),
            OrderCard(status: OrderStatus.onTheWay),
            OrderCard(status: OrderStatus.delivered),
          ],
        ),
      ),
    );
  }
}
