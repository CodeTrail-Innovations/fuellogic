import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/orders/screens/order_history_screen.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/modules/profile/screens/company_profile_screen.dart';
import 'package:fuellogic/modules/profile/screens/components/fleet_card.dart';
import 'package:fuellogic/modules/profile/screens/components/profile_card.dart';
import 'package:get/get.dart';

import '../../company/modules/trucks/screens/vehicle_detail_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = controller.userData.value;
          if (userData == null) {
            return const Center(child: Text('No user data available'));
          }
          return Column(
            children: [
              20.vertical,
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: AppTextStyles.largeStyle.copyWith(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        FleetCard(controller: controller),

                        ProfileCard(
                          onTap: () => Get.to(() => CompanyProfileScreen()),
                          title: 'Profile',
                          subTitle: "Profile picture, name",
                          forIcon: false,
                          icon: '',
                        ),

                        ProfileCard(
                          onTap:
                              () => Get.to(
                                () => OrderHistoryScreen(role: userData.role),
                              ),
                          title: 'Order history',
                          subTitle: "click here to see order details",
                          forIcon: true,
                          icon: AppAssets.clockIcon,
                        ),

                        Obx(() {
                          final vehicle = controller.assignedVehicle.value;
                          if (vehicle == null) return SizedBox.shrink();

                          return Column(
                            children: [
                              ProfileCard(
                                onTap: () {
                                  Get.to(
                                    () => VehicleDetailScreen(vehicle: vehicle),
                                  );
                                },
                                title: 'Assigned Vehicle',
                                subTitle:
                                    "${vehicle.vehicleName} (${vehicle.vehicleNumber})",
                                forIcon: true,
                                icon: AppAssets.carIcon,
                              ),
                            ],
                          );
                        }),

                        userData.role == UserRole.company
                            ? ProfileCard(
                              onTap: () {
                                controller.showCompanyKeyDialog(context);
                              },
                              title: 'Invite Driver',
                              subTitle: "click here to see your ID ",
                              forIcon: true,
                              icon: AppAssets.inviteUserIcon,
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withCustomOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withCustomOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AppButton(
                    text: "Logout",
                    onPressed: controller.logout,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
