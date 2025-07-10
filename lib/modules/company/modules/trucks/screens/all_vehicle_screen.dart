import 'package:flutter/material.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/screens/add_vehicle_screen.dart';
import 'package:fuellogic/modules/company/modules/trucks/screens/components/vehicle_card.dart';
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
                    return VehicleCard(vehicle: vehicle);
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
