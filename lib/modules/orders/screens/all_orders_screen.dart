import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
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

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "All orders(5)",
                style: AppTextStyles.regularStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
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
                          onTap: () => controller.selectText(index),
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
            // GetBuilder<AllOrdersController>(
            //   builder: (orderDetailController) {
            //     final filteredOrders =
            //         orderDetailController.getFilteredOrders();

            //     return Expanded(
            //       child:
            //           filteredOrders.isEmpty
            //               ? Center(
            //                 child: SvgPicture.asset(AppAssets.noOrderImage),
            //               )
            //               : ListView.separated(
            //                 itemCount: filteredOrders.length,
            //                 separatorBuilder: (_, __) => 16.vertical,
            //                 itemBuilder: (_, index) {
            //                   final order = filteredOrders[index];
            //                   return OrderCard(
            //                     orderStatus: order.status,
            //                     isSelected: homeController.selectedOrders
            //                         .contains(order),
            //                     onLongPress: () {
            //                       if (order.status == OrderStatus.notAssigned) {
            //                         homeController.handleOrderLongPress(order);
            //                       }
            //                     },
            //                     onTap:
            //                         () => homeController.handleOrderTap(order),
            //                     orderId: '#${order.id}',
            //                   );
            //                 },
            //               ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
