import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_assets.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/home/screens/home_screen.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  final List<String> _selectedIcons = [
    AppAssets.homeIconFilled,
    AppAssets.orderIconFilled,
    AppAssets.addOrderFilled,
    AppAssets.settingIconFilled,
    AppAssets.prifileIconFilled,
  ];

  final List<String> _unselectedIcons = [
    AppAssets.homeIconLinear,
    AppAssets.orderIconLinear,
    AppAssets.addOrderLinear,
    AppAssets.settingIconLinear,
    AppAssets.prifileIconLinear,
  ];

  final List<Widget> _screens = [
    // Add your screens here
    HomeScreen(),
    // OrderScreen(),
    // AddOrderScreen(),
    // SettingScreen(),
    // ProfileScreen(),
    Placeholder(), Placeholder(), Placeholder(), Placeholder(), Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, left: 36, right: 36),
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
              padding: EdgeInsets.symmetric(vertical: 10),
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
                  return _buildNavItem(index);
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              _selectedIndex == index
                  ? AppColors.primaryColor
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          boxShadow:
              _selectedIndex == index
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
          _selectedIndex == index
              ? _selectedIcons[index]
              : _unselectedIcons[index],
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            _selectedIndex == index ? AppColors.whiteColor : Colors.grey,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
