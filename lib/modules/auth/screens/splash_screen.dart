import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/modules/auth/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    Get.off(() => LoginScreen());
    // User? user = FirebaseAuth.instance.currentUser;

    // log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");

    // if (user != null) {
    //   Get.off(() => CustomBottomBar());
    // } else {
    //   Get.off(() => RegisterScreen());
    // }
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
