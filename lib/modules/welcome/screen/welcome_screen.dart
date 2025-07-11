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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: bannerHeight,
                width: Get.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageResources.banner),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
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
          SizedBox(height: bannerHeight * 0.25),
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
          Obx(() {
            return Row(
              children: [
                _buildTabButton('Home', 0),
                _buildTabButton('Orders', 1),
              ],
            );
          }),
          const Divider(thickness: 1, color: AppColors.grey2),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Our Products & Services', style: AppTextStyles.heading2Style),
          8.vertical,
          Text(
            'Choose from our wide range of fuel and energy solutions',
            style: AppTextStyles.paragraphStyle,
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
            children: [
              _buildProductCard(
                title: 'Petrol',
                description: 'Premium quality petrol for all vehicles',
                icon: Icons.local_gas_station,
                color: Colors.red,
                onTap: () {},
              ),
              _buildProductCard(
                title: 'High Speed Diesel',
                description: 'High-grade diesel for industrial use',
                icon: Icons.fire_truck,
                color: Colors.blue,
                onTap: () {},
              ),
              _buildProductCard(
                title: 'Mobil Oils',
                description: 'Premium lubricants and engine oils',
                icon: Icons.oil_barrel,
                color: Colors.amber,
                onTap: () {},
              ),
              _buildProductCard(
                title: 'Solar Panels',
                description: 'Sustainable solar energy solutions',
                icon: Icons.solar_power,
                color: Colors.green,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withCustomOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withCustomOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              16.vertical,
              Text(
                title,
                style: AppTextStyles.paragraphBoldStyle.copyWith(fontSize: 16),
              ),
              8.vertical,
              Expanded(
                child: Text(
                  description,
                  style: AppTextStyles.captionStyle.copyWith(height: 1.4),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              12.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Now',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.orange, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
