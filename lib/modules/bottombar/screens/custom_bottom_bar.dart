import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:fuellogic/modules/company/screens/dashboard_screen.dart';
import 'package:fuellogic/modules/home/screens/home_screen.dart';
import 'package:fuellogic/modules/orders/screens/create_order_screen.dart';
import 'package:fuellogic/modules/profile/screens/profile_screen.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomBottomBar extends StatefulWidget {
  final bool isCompany;
  final int initialIndex;

  const CustomBottomBar({
    super.key,
    this.initialIndex = 0,
    this.isCompany = false,
  });

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  late int _selectedIndex;
  final controller = Get.put(BottombarController());

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    log('CustomBottomBar - isCompany: ${widget.isCompany}');
    log('Initial index: ${widget.initialIndex}');
  }

  List<Widget> get _screens {
    log('Getting screens - isCompany: ${widget.isCompany}');
    return widget.isCompany
        ? [DashboardScreen(), CreateOrderScreen(), ProfileScreen()]
        : [HomeScreen(), CreateOrderScreen(), ProfileScreen()];
  }

  List<String> get _selectedIcons => [
    AppAssets.homeIconFilled,
    AppAssets.addOrderFilled,
    AppAssets.prifileIconFilled,
  ];

  List<String> get _unselectedIcons => [
    AppAssets.homeIconLinear,
    AppAssets.addOrderLinear,
    AppAssets.prifileIconLinear,
  ];

  void _onItemTapped(int index) {
    log('Bottom bar item tapped - index: $index');
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Building CustomBottomBar with selectedIndex: $_selectedIndex');

    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: _screens[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 36, right: 36),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withCustomOpacity(0.15),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.grey.withCustomOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withCustomOpacity(0.1),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white.withCustomOpacity(0.7),
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_selectedIcons.length, (index) {
                    log(
                      'Building nav item $index - selected: ${_selectedIndex == index}',
                    );
                    return _buildNavItem(index);
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withCustomOpacity(0.3),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                  : [],
        ),
        child: SvgPicture.asset(
          isSelected ? _selectedIcons[index] : _unselectedIcons[index],
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            isSelected ? AppColors.whiteColor : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
