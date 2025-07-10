import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/helper/constants/image_resources.dart';
import 'package:fuellogic/modules/orders/screens/order_history_screen.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/modules/profile/screens/company_profile_screen.dart';
import 'package:fuellogic/modules/profile/screens/components/profile_card.dart';
import 'package:get/get.dart';

import '../../../widgets/qr_alert.dart';
import '../../company/modules/trucks/screens/vehicle_detail_screen.dart';

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
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: AssetImage(ImageResources.banner),
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                  opacity: 0.4,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fleet Card',
                                    style: AppTextStyles.largeStyle.copyWith(fontSize: 20),
                                  ),
                                  70.vertical,
                                  Text(
                                    controller.userData.value?.displayName ?? '',
                                    style: AppTextStyles.largeStyle.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    'Company Id: ${controller.userData.value?.companyId ?? ''}',
                                    style: AppTextStyles.captionStyle.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),

                            // QR Icon Button (top-right)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => QRDialog(
                                      name: controller.userData.value?.displayName ?? '',
                                      companyId: controller.userData.value?.companyId ?? '',
                                      email: controller.userData.value?.email ?? '',
                                    ),
                                  );
                                },
                                child: Icon(Icons.qr_code, size: 28, color: Colors.black),
                              ),
                            ),
                          ],
                        ),


                        // Container(
                        // height: 180,
                        // width: double.infinity,
                        // decoration: BoxDecoration(
                        //   color: Colors.red.shade50,
                        //   borderRadius: BorderRadius.circular(12),
                        //   image: DecorationImage(
                        //       image: AssetImage(ImageResources.banner),
                        //       alignment: Alignment.center,
                        //       fit: BoxFit.cover, opacity: 0.4)
                        // ),
                        //   padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('Fleet Card',style: AppTextStyles.largeStyle.copyWith(
                        //         fontSize: 20
                        //       ),),
                        //       70.vertical,
                        //       Text(controller.userData.value?.displayName ?? '',style: AppTextStyles.largeStyle.copyWith(
                        //           fontSize: 20
                        //       ),),
                        //       Text('Company Id: ${controller.userData.value?.companyId ?? ''}',style: AppTextStyles.captionStyle.copyWith(
                        //           fontSize: 12
                        //       ),),
                        //
                        //     ],
                        //
                        //   ),
                        // ),


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
                                  Get.to(() => VehicleDetailScreen(vehicle: vehicle));
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
