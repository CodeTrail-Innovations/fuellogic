import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
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

import '../../orders/screens/create_order_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SafeArea(
        child: Scaffold(
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
                      image: AppAssets.orderIconFilled,
                      isSvg: true,
                    ),
                  ),
                  Expanded(
                    child: OrderReportCard(
                      forTruck: true,
                      title: 'On the way',
                      stats: controller.onTheWayOrdersCount.toString(),
                      forDelivered: false,
                      image: AppAssets.orderIconLinear,
                      isSvg: true,
                    ),
                  ),
                ],
              ),
              16.vertical,
              // Container(
              //   height: 65,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: AppColors.primaryColor,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: Center(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Fleet Manager', style: AppTextStyles.regularStyle.copyWith(
              //           color: Colors.white,
              //           // fontSize: 18
              //         ),),
              //         Icon(Icons.chevron_right_rounded, color: Colors.white,)
              //       ],
              //     ),
              //   ),
              // ),
              AppButton(
                text: "Place Order",
                onPressed: () {
                  Get.to(() => CreateOrderScreen());
                  // Get.to(() => ReportScreen());
                },
                isIconButton: false,
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
        ),
      );
    });
  }
}
