import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
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

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      User? user = _auth.currentUser;
      log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");

      if (user != null) {
        await _bottomBarController.fetchCurrentUserData();

        Get.off(() => CustomBottomBar());
      } else {
        Get.off(() => AuthScreen());
      }
    } catch (e) {
      log("Error during splash screen navigation: $e");

      Get.off(() => AuthScreen());
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
              'Fuellogic',
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
