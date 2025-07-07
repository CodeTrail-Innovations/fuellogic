import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/screens/auth_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data_manager/models/user_model.dart';
import '../../../helper/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    // Get.offAllNamed(AppRoutes.welcome);

    navigation();

    // User? user = FirebaseAuth.instance.currentUser;
    //
    // log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");
    //
    // if (user != null) {
    //   Get.off(() => CompanyMainScreen());
    // } else {
    //   Get.off(() => AuthScreen());
    // }
  }


  Future<void> navigation() async {
    // await Future.delayed(Duration(seconds: 1));
    final authService = Get.find<AuthService>();
    await authService.loadSession();

    final user = await authService.getCurrentUser();
    if (user != null) {
      _navigateBasedOnRole(user);
    } else {
      Get.offAllNamed(AppRoutes.welcome);
    }
  }

  void _navigateBasedOnRole(UserModel user) {
    switch (user.role) {
      case 'admin':
        Get.offAllNamed(AppRoutes.adminMainScreen);
        break;
      case 'company':
        Get.offAllNamed(AppRoutes.companyMainScreen);
        break;
      default:
        Get.offAllNamed(AppRoutes.welcome);
        break;
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
