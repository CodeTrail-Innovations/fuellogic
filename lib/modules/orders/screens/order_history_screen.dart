import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class OrderHistoryScreen extends StatelessWidget {
  final UserRole role;
  OrderHistoryScreen({super.key, required this.role});

  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    if (role == UserRole.company) {
      controller.fetchCurrentUserOrders();
    } else if (role == UserRole.driver) {
      controller.fetchCurrentUserDriverOrders();
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final deliveredOrders =
            controller.ordersList
                .where((order) => order.orderStatus == OrderStatus.delivered)
                .toList();

        if (deliveredOrders.isEmpty) {
          return Center(
            child: Text(
              "No delivered orders found",
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 16,
            children: [
              Row(
                spacing: 6,
                children: [
                  SvgPicture.asset(
                    AppAssets.orderIconFilled,
                    colorFilter: ColorFilter.mode(
                      AppColors.progressColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Text(
                    "Delivered orders",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.progressColor,
                    ),
                  ),
                ],
              ),
              4.vertical,
              Expanded(
                child: ListView.builder(
                  itemCount: deliveredOrders.length,
                  itemBuilder: (context, index) {
                    final order = deliveredOrders[index];
                    return OrderCard(order: order);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
