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
import 'package:fuellogic/modules/profile/screens/components/profile_card.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
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
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profile",
                          style: AppTextStyles.largeStyle.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),

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
                          if (vehicle == null) return Text("data");

                          return Column(
                            children: [
                              ProfileCard(
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: Text('Fuel Information'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Capacity: ${vehicle.vehicleCapacity}',
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text('Close'),
                                        ),
                                      ],
                                    ),
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
                              subTitle: "click here to see your ",
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
                child: AppButton(text: "Logout", onPressed: controller.logout),
              ),
            ],
          );
        }),
      ),
    );
  }
}
