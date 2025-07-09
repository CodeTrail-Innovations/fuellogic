import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/orders/screens/order_history_screen.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/modules/setting/screens/components/setting_card.dart';
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        24.vertical,
                        Text(
                          "Profile",
                          style: AppTextStyles.largeStyle.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),

                        24.vertical,
                        Center(
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            radius: 75,
                            child: Icon(
                              size: 50,
                              Icons.person,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                        24.vertical,
                        Text(
                          userData.displayName,
                          style: AppTextStyles.regularStyle,
                        ),
                        8.vertical,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withCustomOpacity(.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            userData.role.name,
                            style: AppTextStyles.paragraphStyle.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        24.vertical,
                        SettingCard(
                          onTap:
                              () => Get.to(
                                () => OrderHistoryScreen(role: userData.role),
                              ),
                          title: 'Order history',
                          subTitle: "click here to see order details",
                          forIcon: true,
                          icon: AppAssets.clockIcon,
                        ),
                        16.vertical,

                        // FutureBuilder<String?>(
                        //   future: controller.fetchCompanyNameForDriver(),
                        //   builder: (context, snapshot) {
                        //     final companyName = snapshot.data ?? 'Loading...';
                        //     return SettingCard(
                        //       title: companyName,
                        //       subTitle: "click here to see company details",
                        //       forIcon: true,
                        //       icon: AppAssets.clockIcon,
                        //     );
                        //   },
                        // ),
                        // 16.vertical,
                        userData.role == UserRole.company
                            ? SettingCard(
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
