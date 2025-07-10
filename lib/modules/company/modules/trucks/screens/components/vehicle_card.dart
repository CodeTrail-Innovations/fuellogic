import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/company/controllers/report_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/models/vehicle_model.dart';
import 'package:fuellogic/modules/company/modules/trucks/screens/vehicle_detail_screen.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

class VehicleCard extends StatelessWidget {
  VehicleCard({super.key, required this.vehicle});
  final controller = Get.put(ReportController());
  final vehicleController = Get.put(VehicleController());

  final VehicleModel vehicle;

  void _showDriversBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.driversList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No drivers available'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vehicle.assignDriverId.isEmpty
                      ? 'Assign Driver to ${vehicle.vehicleName}'
                      : 'Change Driver for ${vehicle.vehicleName}',
                  style: AppTextStyles.regularStyle,
                ),
                16.vertical,
                if (vehicle.assignDriverId.isNotEmpty) ...[
                  ListTile(
                    leading: const Icon(
                      Icons.person_remove,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      'Unassign Current Driver',
                      style: AppTextStyles.paragraphStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),

                    onTap: () {
                      vehicleController.unassignDriverFromVehicle(vehicle.id);
                      Get.back();
                    },
                  ),
                  const Divider(),
                ],
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.driversList.length,
                    itemBuilder: (context, index) {
                      final driver = controller.driversList[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                vehicle.assignDriverId == driver.uid
                                    ? AppColors.primaryColor
                                    : AppColors.transparentColor,
                          ),
                          color:
                              vehicle.assignDriverId == driver.uid
                                  ? AppColors.primaryColor.withCustomOpacity(.1)
                                  : AppColors.transparentColor,
                        ),
                        child: ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          title: Text(
                            driver.displayName,
                            style: AppTextStyles.regularStyle.copyWith(
                              color:
                                  vehicle.assignDriverId == driver.uid
                                      ? AppColors.primaryColor
                                      : AppColors.mainColor,
                            ),
                          ),
                          subtitle: Text(
                            driver.email,
                            style: AppTextStyles.paragraphStyle.copyWith(
                              color:
                                  vehicle.assignDriverId == driver.uid
                                      ? AppColors.primaryColor
                                      : AppColors.mainColor,
                            ),
                          ),
                          trailing:
                              vehicle.assignDriverId == driver.uid
                                  ? const Icon(
                                    Icons.check,
                                    color: AppColors.primaryColor,
                                  )
                                  : IconButton(
                                    onPressed: () {
                                      if (vehicle.assignDriverId !=
                                          driver.uid) {
                                        vehicleController.assignDriverToVehicle(
                                          vehicleId: vehicle.id,
                                          driverId: driver.uid,
                                          driverName: driver.displayName,
                                        );
                                        Get.back();
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                          // onTap: () {
                          // if (vehicle.assignDriverId != driver.uid) {
                          //   vehicleController.assignDriverToVehicle(
                          //     vehicleId: vehicle.id,
                          //     driverId: driver.uid,
                          //     driverName: driver.displayName,
                          //   );
                          //   Get.back();
                          // }
                          // },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => VehicleDetailScreen(vehicle: vehicle)),
      child: Container(
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
                color: AppColors.primaryColor.withCustomOpacity(0.3),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryColor.withCustomOpacity(0.1),
              child: SvgPicture.asset(
                AppAssets.carIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          title: Text(
            'Vehicle Name: ${vehicle.vehicleName}',
            style: AppTextStyles.regularStyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vehicle Number# ${vehicle.vehicleNumber}',
                  style: AppTextStyles.paragraphStyle,
                ),
                if (vehicle.driverName.isNotEmpty)
                  Text(
                    'Driver: ${vehicle.driverName}',
                    style: AppTextStyles.paragraphStyle.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          trailing: InkWell(
            onTap: () => _showDriversBottomSheet(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color:
                    vehicle.assignDriverId.isEmpty
                        ? AppColors.primaryColor.withCustomOpacity(0.1)
                        : Colors.green.withCustomOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      vehicle.assignDriverId.isEmpty
                          ? AppColors.primaryColor.withCustomOpacity(0.3)
                          : Colors.green.withCustomOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                vehicle.assignDriverId.isEmpty ? 'Assign' : 'Assigned',
                style: TextStyle(
                  color:
                      vehicle.assignDriverId.isEmpty
                          ? AppColors.primaryColor
                          : Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
