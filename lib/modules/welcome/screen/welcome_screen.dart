import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/helper/constants/app_assets.dart';
import 'package:fuellogic/helper/constants/image_resources.dart';
import 'package:fuellogic/helper/extensions/space_extensions.dart';

import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../controller/welcome_controller.dart';
import 'package:icons_plus/icons_plus.dart';

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
                      color: Colors.transparent,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Fuelogic', style: AppTextStyles.heading2Style),
                InkWell(
                  onTap: (){
                    Get.toNamed(AppRoutes.authScreen);
                  },
                  child: Container(
                    // height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withCustomOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),

                    ),
                    // child: TextButton(onPressed: (){}, child: Text('Get Started')),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Get Started', style: AppTextStyles.paragraphStyle.copyWith(
                          color: Colors.white
                        ),),
                        5.horizontal,
                        Icon(Icons.chevron_right, color: Colors.white,),
                      ],
                    ),
                  ),
                )
              ],
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
                  Text('Fuellogict.com', style: AppTextStyles.captionStyle),
                ],
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     border: Border.all(color: AppColors.grey2),
              //   ),
              //   padding: EdgeInsets.all(10),
              //   // child: Text('Message', style: AppTextStyles.captionStyle),
              // ),
            ],
          ),
          _contactTile(CupertinoIcons.phone, 'Phone Number', '+923350897643'),

          _contactTile(
            Icons.location_on_outlined,
            'Location',
            'Office # 12, 5th Floor City Star Shopping Mall, Model Town Link Road, Lahore',
          ),
          24.vertical,
          // Social Links

          Row(
            children: [
              _brandContainer(Brands.instagram, (){}),
              _brandContainer(Brands.facebook, (){}),
              _brandContainer(Brands.twitterx_2, (){}),
              _brandContainer(Brands.youtube, (){}),
              _brandContainer(Brands.tiktok, (){}),

            ],
          ),
          24.vertical,
          Center(
            child: Text('Fuelogic Copyright © 2025', style: AppTextStyles.captionBold.copyWith(
                fontSize: 15
            ),),
          ),
          4.vertical,
          Center(
            child: Text(
              'All rights reserved by Fuelogic. Unauthorized use is strictly prohibited.',
              textAlign: TextAlign.center,
              style: AppTextStyles.captionStyle.copyWith(
                fontSize: 12
            ),),
          ),
          4.vertical,
          Center(
            child: Text(
              'For more information, visit: fuellogict.com',
              textAlign: TextAlign.center,
              style: AppTextStyles.captionStyle.copyWith(
                  fontSize: 12
              ),),
          ),

          Center(
            child: TextButton(onPressed: (){
              Get.toNamed(AppRoutes.complianceScreen);
            }, child: Text(
              'Privacy Policy | Terms & Conditions',
              textAlign: TextAlign.center,
              style: AppTextStyles.captionStyle.copyWith(
                  fontSize: 12
              ),)),
          ),
          8.vertical,

          

          
        ],
      ),
    );
  }

  Widget _brandContainer(String brand,Function() onPressed){
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(

        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade400

        ),
        padding: EdgeInsets.all(8),
        child: Center(child: Brand(brand, size: 35,)),
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.withCustomOpacity(0.1),
                  Colors.red.withCustomOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.orange.withCustomOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withCustomOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.local_shipping,
                    color: Colors.orange,
                    size: 24,
                  ),
                ),
                16.horizontal,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Professional Fuel Services',
                        style: AppTextStyles.paragraphBoldStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      4.vertical,
                      Text(
                        'Commercial fuel delivery & energy solutions',
                        style: AppTextStyles.captionStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          24.vertical,
          Column(
            children: [
              _buildEnhancedFuelCard(
                imagePath: AppAssets.petrolImage,
                title: 'PETROL',
                subtitle: 'Premium Unleaded',
                description:
                    'High-octane petrol for all vehicle types with guaranteed quality and nationwide delivery service',

                color: const Color(0xFFE53E3E),
                icon: Icons.local_gas_station,
                onTap: () {
                  Get.toNamed(AppRoutes.authScreen);
                },
              ),
              24.vertical,
              _buildEnhancedFuelCard(
                imagePath: AppAssets.dieselImage,
                title: 'HIGH SPEED DIESEL',
                subtitle: 'Commercial Grade',
                description:
                    'Premium HSD for trucks, generators and heavy machinery with superior performance',
                color: const Color(0xFF3182CE),
                icon: Icons.fire_truck,
                onTap: () {
                  Get.toNamed(AppRoutes.authScreen);
                },
              ),
              24.vertical,
              _buildEnhancedFuelCard(
                imagePath: AppAssets.mobilImage,
                title: 'MOBIL OILS',
                subtitle: 'Premium Lubricants',
                description:
                    'Complete range of engine oils, hydraulic fluids and specialized lubricants',

                color: const Color(0xFFD69E2E),
                icon: Icons.oil_barrel,
                onTap: () {
                  Get.toNamed(AppRoutes.authScreen);
                },
              ),
              24.vertical,
              _buildEnhancedFuelCard(
                imagePath: AppAssets.solarImage,
                title: 'SOLAR PANELS',
                subtitle: 'Clean Energy',
                description:
                    'Complete solar installation with maintenance, monitoring and long-term support',

                color: const Color(0xFF38A169),
                icon: Icons.solar_power,
                onTap: () {
                  Get.toNamed(AppRoutes.authScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedFuelCard({
    required String title,
    required String subtitle,
    required String imagePath,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withCustomOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: color.withCustomOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withCustomOpacity(0.85),
                        Colors.black.withCustomOpacity(0.7),
                        Colors.black.withCustomOpacity(0.4),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withCustomOpacity(0.5)],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withCustomOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      8.horizontal,
                      Text(
                        'FUE',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'LOGIC',
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 24,
                top: 24,
                bottom: 24,
                right: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withCustomOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: color.withCustomOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),

                    16.vertical,

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            height: 1.1,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                        4.vertical,
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),

                    12.vertical,

                    Expanded(
                      child: Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withCustomOpacity(0.9),
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withCustomOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ORDER NOW',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          12.horizontal,
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
