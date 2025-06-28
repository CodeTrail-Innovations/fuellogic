import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/profile/controllers/profile_controller.dart';
import 'package:fuellogic/modules/setting/screens/components/setting_card.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

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
                        Row(
                          children: [
                            Text(
                              "Profile",
                              style: AppTextStyles.largeStyle.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Spacer(),
                            SvgPicture.asset(AppAssets.editProfileIcon),
                          ],
                        ),
                        24.vertical,
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
                            ),
                            radius: 75,
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
                          title: 'Order history',
                          subTitle: "click here to see order details",
                          forIcon: true,
                          icon: AppAssets.clockIcon,
                        ),
                        16.vertical,
                        SettingCard(
                          onTap: () {
                            controller.showCompanyKeyDialog(context);
                          },
                          title: 'Invite Driver',
                          subTitle: "click here to see your ",
                          forIcon: true,
                          icon: AppAssets.inviteUserIcon,
                        ),
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
