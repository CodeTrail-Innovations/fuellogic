// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/modules/orders/controllers/all_orders_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class AllOrdersScreen extends StatelessWidget {
  AllOrdersScreen({super.key});
  final controller = Get.put(AllOrdersController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "All orders(${controller.filteredOrders.length})",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
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
                            margin: EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
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
                ),
                16.vertical,
                controller.filteredOrders.isEmpty
                    ? Center(
                      child: Text(
                        "No orders found.",
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                    : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = controller.filteredOrders[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OrderCard(order: order),
                          );
                        },
                      ),
                    ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
