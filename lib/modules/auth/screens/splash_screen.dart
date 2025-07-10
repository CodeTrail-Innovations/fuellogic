import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/constants/keys.dart';
import 'package:fuellogic/helper/utils/hive_utils.dart';
import 'package:fuellogic/modules/auth/screens/auth_screen.dart';
import 'package:fuellogic/modules/bottombar/controllers/bottombar_controller.dart';
import 'package:fuellogic/modules/bottombar/screens/custom_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  final _bottomBarController = Get.put(BottombarController());
  int? initialIndex;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    try {

      final role= HiveBox().getValue(key: roleKey);
      log("saved role: $role");

      User? user = _auth.currentUser;
      log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");

      if (user != null) {
        await _bottomBarController.fetchCurrentUserData();

        final userRole = _bottomBarController.userData.value?.role.label ?? '';

        log(userRole);
        final isCompany = userRole == 'Company';

        Get.offAll(() => CustomBottomBar(isCompany: role == companyRoleKey ? true : false));
      } else {
        Get.offAllNamed(AppRoutes.welcomeScreen);
      }
    } catch (e) {
      log("Error during splash screen navigation: $e");
      Get.offAllNamed(AppRoutes.welcomeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              'Fuelogic',
              style: GoogleFonts.racingSansOne(
                textStyle: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Text(
              'Smart Fueling for Smart Lives.',
              style: GoogleFonts.racingSansOne(
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
