import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Spacer(),
              AppButton(
                btnRadius: 100,
                text: 'Company',
                onPressed:
                    () => controller.goToRegisterScreen(UserRole.company),
              ),
              16.vertical,
              AppButton(
                btnRadius: 100,
                text: 'Driver',
                isOutline: true,
                onPressed: () => controller.goToRegisterScreen(UserRole.driver),
              ),
              24.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
