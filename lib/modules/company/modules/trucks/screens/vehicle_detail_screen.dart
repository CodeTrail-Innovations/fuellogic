import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/modules/company/modules/trucks/controllers/vehicle_controller.dart';
import 'package:fuellogic/modules/company/modules/trucks/models/vehicle_model.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class VehicleDetailScreen extends StatelessWidget {
  const VehicleDetailScreen({super.key, required this.vehicle});
  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VehicleController());
    final TextEditingController logController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initVehicleStream(vehicle.id);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(
          isSimple: true,
          height: 55,
          title: 'Vehicle detail',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withCustomOpacity(.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.vehicleName,
                      style: AppTextStyles.largeStyle.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    4.vertical,
                    Text(
                      vehicle.vehicleNumber,
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    16.vertical,
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            'Capacity',
                            vehicle.vehicleCapacity,
                            Icons.local_gas_station,
                          ),
                        ),
                        Expanded(
                          child: _buildInfoCard(
                            'Driver',
                            vehicle.driverName,
                            Icons.person,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.history, color: AppColors.whiteColor, size: 20),
                    8.horizontal,
                    Text(
                      'Activity Logs',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Obx(() {
                    final currentVehicle = controller.currentVehicle ?? vehicle;
                    final logs = currentVehicle.logs.reversed.toList();

                    if (logs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 48,
                              color: Colors.grey[600],
                            ),
                            12.vertical,
                            Text(
                              'No logs yet',
                              style: AppTextStyles.regularStyle.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Activity will appear here',
                              style: AppTextStyles.captionStyle.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return _buildLogEntry(log, index);
                      },
                    );
                  }),
                ),
              ),
              16.vertical,
              Row(
                children: [
                  Expanded(
                    child: AppFeild(
                      controller: logController,
                      hintText: "Add a log entry...",
                    ),
                  ),
                  12.horizontal,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      onPressed: () => _addLog(controller, logController),
                      icon: const Icon(Icons.send, color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
              8.vertical,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.greyColor),
              4.horizontal,
              Text(
                label,
                style: AppTextStyles.captionStyle.copyWith(
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
          4.vertical,
          Text(
            value,
            style: AppTextStyles.regularStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(Map<String, dynamic> log, int index) {
    final timestamp = formatDate(log['createdDate']);
    // final timestamp = _formatTimestamp(log['createdDate']);
    final username = log['username'] ?? 'Unknown';
    final message = log['logsMessage'] ?? '';
    final role = log['role'] ?? '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              timestamp,
              style: AppTextStyles.captionStyle.copyWith(
                color: Colors.green[400],
                fontFamily: 'monospace',
              ),
            ),
          ),
          8.horizontal,

          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
            ),
          ),
          12.horizontal,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: username,
                        style: AppTextStyles.paragraphStyle.copyWith(
                          color: Colors.blue[300],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' [$role]',
                        style: AppTextStyles.captionStyle.copyWith(
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                4.vertical,

                Text(
                  message,
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: Colors.grey[300],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addLog(
    VehicleController controller,
    TextEditingController logController,
  ) {
    if (logController.text.trim().isEmpty) return;

    controller.addVehicleLog(
      vehicleId: vehicle.id,
      message: logController.text.trim(),
    );

    logController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  String formatDate(String? isoDate) {
    if (isoDate == null) return '';
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }
}
