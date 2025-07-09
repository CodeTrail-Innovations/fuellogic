import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/profile/screens/company_profile_screen.dart';
import 'package:get/get.dart';

import 'components/setting_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              24.vertical,
              Text(
                "Settings",
                style: AppTextStyles.largeStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SettingCard(
                onTap: () => Get.to(() => CompanyProfileScreen()),
                title: 'Profile',
                subTitle: "Profile picture, name",
                forIcon: false,
                icon: '',
              ),
              // SettingCard(
              //   title: 'Notifications',
              //   subTitle: "preferences, notifications types",
              //   forIcon: true,
              //   icon: AppAssets.notificationIcon,
              // ),
              SettingCard(
                title: 'Legal',
                subTitle: "Privacy policy, terms of use",
                forIcon: true,
                icon: AppAssets.legalIcon,
              ),
              SettingCard(
                title: 'Help and support',
                subTitle: "FAQs, contact",
                forIcon: true,
                icon: AppAssets.clockIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
