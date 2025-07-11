import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/modules/admin/admin_main/admin_main_controller.dart';
import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import '../../home/screens/components/order_card.dart';

class AdminMainScreen extends StatelessWidget {
  AdminMainScreen({super.key});
  final controller = Get.put(AdminMainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Management'),
        actions: [
          IconButton(onPressed: ()=> controller.logout(), icon: Icon(Icons.logout_rounded))

        ],
      ),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(child: Text('No Orders Found'));
        }

        return Column(
          children: [
            Column(
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
                16.vertical,
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
                              border: Border.all(
                                color: AppColors.primaryColor,
                              ),
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
              ],
            ),

            Expanded(
              child:
              controller.filteredOrders.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    "No orders found.",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: controller.filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = controller.filteredOrders[index];
                  return OrderCard(order: order);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
