import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/admin/admin_main/admin_main_controller.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import '../../../helper/services/notification_services.dart';
import '../../home/screens/components/order_card.dart';

class AdminMainScreen extends StatefulWidget {
  AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  final controller = Get.put(AdminMainController());

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    if(Platform.isAndroid){
      notificationServices.subscribeToTopic('Android_Users');
    }
    else if(Platform.isIOS){
      notificationServices.subscribeToTopic('iOS_Users');
    }
    notificationServices.foregroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('DEVICE TOKEN');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Order Management',style: AppTextStyles.largeStyle.copyWith(
          color: AppColors.primaryColor
        ),),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: ()=> Get.toNamed(AppRoutes.adminProfileScreen),
              // onPressed: ()=> controller.logout(),
              icon: Icon(Iconsax.profile_circle_outline, color: AppColors.primaryColor,))

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
