import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/modules/company/screens/components/order_report_card.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});
  final controller = Get.put(ProfileController());
  final reportController = Get.put(ReportController());

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
            children: [
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OrderReportCard(
                      title: 'Total drivers',
                      stats: 'no stats',
                      forDelivered: true,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OrderReportCard(
                      title: 'On the way',
                      stats: reportController.onTheWayOrdersCount.toString(),
                      forDelivered: false,
                    ),
                  ),
                ],
              ),
              16.vertical,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      OrderStatus.values.map((status) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                reportController.selectedStatus.value == status,
                            selectedColor: AppColors.primaryColor,
                            backgroundColor: AppColors.primaryColor
                                .withCustomOpacity(.2),
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
              SizedBox(height: 16),
              // Filtered orders list
              ...reportController.filteredOrders.map(
                (order) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrderCard(order: order),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
