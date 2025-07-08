import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/modules/company/screens/components/order_report_card.dart';
import 'package:fuellogic/modules/company/screens/report_screen.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Scaffold(
        appBar: CustomAppBar(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            Text(
              "Your company stats",
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            16.vertical,
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: OrderReportCard(
                    title: 'Delivered',
                    stats: controller.deliveredOrdersCount.toString(),
                    forDelivered: true,
                  ),
                ),
                Expanded(
                  child: OrderReportCard(
                    title: 'On the way',
                    stats: controller.onTheWayOrdersCount.toString(),
                    forDelivered: false,
                  ),
                ),
              ],
            ),
            16.vertical,
            AppButton(
              text: "View report",
              onPressed: () {
                Get.to(() => ReportScreen());
              },
              isIconButton: true,
              icon: Icons.arrow_forward,
            ),
            24.vertical,
            Text(
              "Recent Orders",
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            20.vertical,
            ...controller.ordersList.map((order) => OrderCard(order: order)),
          ],
        ),
      );
    });
  }
}
