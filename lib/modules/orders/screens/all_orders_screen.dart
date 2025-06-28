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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: GetBuilder<AllOrdersController>(
                  builder: (controller) {
                    return Text(
                      "All orders(${controller.filteredOrders.length})",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              GetBuilder<AllOrdersController>(
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
              16.vertical,
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
        ),
      ),
    );
  }
}
