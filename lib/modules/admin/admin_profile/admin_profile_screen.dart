import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/admin/admin_profile/admin_profile_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_button.dart';
import '../../../core/constant/app_colors.dart';
import '../../profile/screens/components/profile_card.dart';

class AdminProfileScreen extends StatelessWidget {
  AdminProfileScreen({super.key});

  final controller = Get.put(AdminProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          isSimple: true,
          title: 'Profile',
        ),
        backgroundColor: const Color(0xFFF8F9FA),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final userData = controller.userData.value;
          if (userData == null) {
            return const Center(child: Text('No user data available'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(()=>Text(
                  controller.userData.value?.displayName ?? '',
                  style: AppTextStyles.largeStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
                10.vertical,
                Obx(()=>Text(
                  controller.userData.value?.email ?? '',
                  style: AppTextStyles.paragraphStyle.copyWith(
                    color: AppColors.mainColor,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
                ),),
                10.vertical,
                ProfileCard(
                  onTap: () {
                    Get.toNamed(AppRoutes.addNewAdminScreen);
                  },
                  title: 'Add New Admin',
                  subTitle: "Click here to add new admin ",
                  forIcon: true,
                  icon: AppAssets.inviteUserIcon,
                )
                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //       child: Column(
                //         spacing: 20,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Obx(()=>Text(
                //             controller.userData.value?.displayName ?? '',
                //             style: AppTextStyles.largeStyle.copyWith(
                //               color: AppColors.primaryColor,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),),
                //           Obx(()=>Text(
                //             controller.userData.value?.email ?? '',
                //             style: AppTextStyles.largeStyle.copyWith(
                //               color: AppColors.mainColor,
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),),
                //
                //
                //
                //
                //
                //
                //
                //
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

              ],
            ),
          );
        }),
        bottomNavigationBar: Padding(
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
      ),
    );
  }
}
