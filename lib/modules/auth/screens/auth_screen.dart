import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 16,
            children: [
              Spacer(),
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
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              AppButton(
                height: 55,
                btnRadius: 100,
                text: 'Company',
                onPressed:
                    () => controller.goToRegisterScreen(UserRole.company),
              ),
              AppButton(
                height: 55,
                btnRadius: 100,
                text: 'Driver',
                isOutline: true,
                onPressed: () => controller.goToRegisterScreen(UserRole.driver),
              ),
              8.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
