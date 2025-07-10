import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/screens/all_vehicle_screen.dart';
import 'package:fuellogic/modules/company/screens/all_driver_screen.dart';
import 'package:fuellogic/modules/company/screens/components/order_report_card.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final controller = Get.put(ProfileController());
  final reportController = Get.put(ReportController());
  final vehicleController = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   // leading: InkWell(
        //   //   onTap: ()=> Get.back(),
        //   //     child: Icon(Icons.chevron_left_rounded, color: AppColors.blackColor,)),
        //   backgroundColor: AppColors.whiteColor,
        //   title: Text('Fleet Manager', style: AppTextStyles.extraLargeStyle.copyWith(
        //   color: AppColors.mainColor,
        //     fontSize: 18
        //   ),),
        // ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = controller.userData.value;
          if (userData == null) {
            return const Center(child: Text('No user data available'));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.vertical,
                Text(
                  textAlign: TextAlign.start,
                  "Fleet Manager",
                  style: AppTextStyles.largeStyle.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                16.vertical,
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: OrderReportCard(
                        ontap: () => Get.to(() => AllDriverScreen()),
                        title: 'Total drivers',
                        stats: userData.driver!.length.toString(),
                        forDelivered: true,
                        image: AppAssets.driverImage,
                        isSvg: false,
                      ),
                    ),

                    Expanded(
                      child: OrderReportCard(
                        ontap: () => Get.to(() => AllVehicleScreen()),
                        title: 'Total cars',
                        stats: vehicleController.totalVehicles.toString(),
                        forDelivered: false,
                        image: AppAssets.carIcon,
                        isSvg: true,
                      ),
                    ),
                  ],
                ),
                16.vertical,
                OrderReportCard(
                  forTruck: true,
                  title: 'On the way',
                  stats: reportController.onTheWayOrdersCount.toString(),
                  forDelivered: false,
                  image: AppAssets.orderIconLinear,
                  isSvg: true,
                ),
                16.vertical,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        OrderStatus.values.map((status) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: FilterChip(
                              label: Text(
                                status.label,
                                style: TextStyle(
                                  color:
                                      reportController.selectedStatus.value ==
                                              status
                                          ? Colors.white
                                          : AppColors.primaryColor,
                                ),
                              ),
                              selected:
                                  reportController.selectedStatus.value ==
                                  status,
                              selectedColor: AppColors.primaryColor,
                              backgroundColor: AppColors.primaryColor
                                  .withCustomOpacity(.1),
                              checkmarkColor: Colors.white,
                              showCheckmark: true,
                              onSelected: (selected) {
                                reportController.selectedStatus.value =
                                    selected ? status : null;
                              },
                            ),
                          );
                        }).toList(),
                  ),
                ),
                20.vertical,
                ...reportController.filteredOrders.map(
                  (order) => OrderCard(order: order),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
