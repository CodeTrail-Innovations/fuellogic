// presentation/screens/home_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/helper/constants/image_resources.dart';
import 'package:fuellogic/helper/extensions/space_extensions.dart';
import 'package:fuellogic/helper/theme/app_colors.dart';
import 'package:fuellogic/helper/theme/app_text_styles.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/routes/app_router.dart';
import '../controller/welcome_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final c = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    final bannerHeight = MediaQuery.of(context).size.height * 0.30;

    return Scaffold(
      backgroundColor: AppColors.grey1,
      body: Column(
        children: [
          // ─── Banner + Logo Stack ───
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Banner
              Container(
                height: bannerHeight,
                width: Get.width,

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageResources.banner),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ), // replace with your banner image via DecorationImage if you like
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 35,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.person_crop_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () => Get.toNamed(AppRoutes.authScreen),
                  ),
                ),
              ),

              // Logo overlapping
              Positioned(
                bottom: -bannerHeight * 0.20,
                left: 16,
                child: Container(
                  width: bannerHeight * 0.45,
                  height: bannerHeight * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage(ImageResources.logo2),
                      fit: BoxFit.contain,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withCustomOpacity(.2),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Push subsequent content down to clear logo overlap
          SizedBox(height: bannerHeight * 0.25),

          // Company name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Fuelogic', style: AppTextStyles.heading2Style),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fueling Operations',
                style: AppTextStyles.paragraphStyle,
              ),
            ),
          ),

          16.vertical,

          // ─── Tabs ───
          Obx(() {
            return Row(
              children: [
                _buildTabButton('Home', 0),
                _buildTabButton('Orders', 1),
              ],
            );
          }),

          const Divider(thickness: 1, color: AppColors.grey2),

          // ─── Content ───
          Expanded(
            child: Obx(() {
              return c.selectedTab.value == 0
                  ? _buildHomeTab()
                  : _buildOrdersTab();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => c.selectTab(index),
        child: Container(
          color: Colors.transparent,
          // padding: const EdgeInsets.symmetric(vertical: 2),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color:
                    c.selectedTab.value == index ? Colors.orange : Colors.black,
                fontWeight:
                    c.selectedTab.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dummy Description
          Text(
            'Fuelogic provides nationwide fuel supply, Genset maintenance, and customized solar solutions for corporate clients. We Offer round-the-clock diesel.',
            style: AppTextStyles.paragraphStyle,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Get in touch', style: AppTextStyles.paragraphBoldStyle),
                  Text('Fuelogict', style: AppTextStyles.captionStyle),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.grey2),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Message', style: AppTextStyles.captionStyle),
              ),
            ],
          ),
          _contactTile(CupertinoIcons.phone, 'Phone Number', '+923008272842'),
          _contactTile(
            CupertinoIcons.barcode_viewfinder,
            'Invite Code',
            '8ERALC',
          ),
          _contactTile(
            Icons.location_on_outlined,
            'Location',
            'Lt. Col Sheraz Ali Khan Shaheed Road',
          ),

          24.vertical,

          // Social Links
          Row(
            children: [
              _brandContainer(Brands.instagram, () {}),
              _brandContainer(Brands.facebook, () {}),
              _brandContainer(Brands.twitterx_2, () {}),
              _brandContainer(Brands.youtube, () {}),
              _brandContainer(Brands.tiktok, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _brandContainer(String brand, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade400,
        ),
        padding: EdgeInsets.all(8),
        child: Center(child: Brand(brand, size: 35)),
      ),
    );
  }

  // Widget _contactTile(IconData icon, String label, String value) {
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Divider(),
  //       ListTile(
  //         contentPadding: EdgeInsets.zero,
  //         title: Text(value, style: AppTextStyles.paragraphBoldStyle,),
  //         subtitle: Text(label, style: AppTextStyles.captionStyle,),
  //       ),
  //     ],
  //   );
  // }

  Widget _contactTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          Divider(color: AppColors.grey2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: AppTextStyles.paragraphBoldStyle),
                    Text(label, style: AppTextStyles.captionStyle),
                  ],
                ),
              ),

              Icon(icon, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for images
          Container(
            width: 120,
            height: 120,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, size: 60, color: Colors.white54),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Order'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () => Get.toNamed(AppRoutes.authScreen),
          ),
        ],
      ),
    );
  }
}
