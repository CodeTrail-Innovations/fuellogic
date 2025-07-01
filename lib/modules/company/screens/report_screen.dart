import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
import 'package:fuellogic/modules/company/screens/components/order_report_card.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/modules/orders/controllers/all_orders_controller.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final userData = controller.userData.value;
        if (userData == null) {
          return const Center(child: Text('No user data available'));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            spacing: 16,
            children: [
              Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: OrderReportCard(
                      title: 'Total drivers',
                      stats: userData.driver.length.toString(),
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
              GetBuilder<AllOrdersController>(
                init: AllOrdersController(),
                builder: (controller) {
                  return SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(controller.orderFilter.length, (
                          index,
                        ) {
                          return GestureDetector(
                            onTap: () => controller.selectFilter(index),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.selectedIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                controller.orderFilter[index],
                                style: (AppTextStyles.regularStyle).copyWith(
                                  fontFamily: AppFonts.publicSansRegular,
                                  color:
                                      controller.selectedIndex == index
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
              GetBuilder<AllOrdersController>(
                builder: (controller) {
                  return Column(
                    children:
                        controller.filteredOrders
                            .map(
                              (order) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OrderCard(status: order),
                              ),
                            )
                            .toList(),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
