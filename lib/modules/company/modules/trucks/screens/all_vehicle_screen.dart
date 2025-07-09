import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/screens/add_vehicle_screen.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class AllVehicleScreen extends StatelessWidget {
  AllVehicleScreen({super.key});
  final controller = Get.put(VehicleController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Get.to(() => AddVehicleScreen()),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.vehicles.isEmpty) {
            return const Center(child: Text('No vehicles found'));
          }
          return Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.vehicles.length,
                  itemBuilder: (context, index) {
                    final vehicle = controller.vehicles[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blackColor.withCustomOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryColor.withCustomOpacity(
                                0.3,
                              ),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.primaryColor
                                .withCustomOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                              size: 28,
                            ),
                          ),
                        ),
                        title: Text(
                          'Vehicle Name: ${vehicle.vehicleName}',
                          style: AppTextStyles.regularStyle,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Vehicle Number# ${vehicle.vehicleNumber}',
                            style: AppTextStyles.paragraphStyle,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withCustomOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.primaryColor.withCustomOpacity(
                                0.3,
                              ),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
