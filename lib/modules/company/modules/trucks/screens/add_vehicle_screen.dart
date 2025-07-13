import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class AddVehicleScreen extends StatelessWidget {
  AddVehicleScreen({super.key});
  final controller = Get.put(VehicleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isSimple: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              "Add Vehicle",
              style: AppTextStyles.largeStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            8.vertical,
            Text("Vehicle Name", style: AppTextStyles.regularStyle),
            AppFeild(
              hintText: "Vehicle Name",
              controller: controller.vehicleNameController,
            ),
            Text("Vehicle Number", style: AppTextStyles.regularStyle),
            AppFeild(
              hintText: "Vehicle Number",
              controller: controller.vehicleNumberController,
            ),
            Text("Vehicle Capacity", style: AppTextStyles.regularStyle),
            AppFeild(
              hintText: "Vehicle Capacity",
              controller: controller.vehicleCapacityController,
            ),
            Obx(
              () => AppButton(
                text: "Add Vehicle",
                onPressed: () {
                  controller.createVehicle();
                },
                isLoading: controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
