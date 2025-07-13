import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/controllers/login_controller.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final UserRole? userRole;

  LoginScreen({super.key}) : userRole = Get.arguments;
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    log("User Role: $userRole");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppBar(
        isSimple: true,
        height: 70,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back",
              style: AppTextStyles.extraLargeStyle.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              "You know the drills",
              style: AppTextStyles.regularStyle,
            ),
            8.vertical,
            Text("Email", style: AppTextStyles.regularStyle),
            AppFeild(
              hintText: "someone@mail.com",
              controller: controller.emailController,
            ),
            Text("Password", style: AppTextStyles.regularStyle),
            AppFeild(
              isPasswordField: true,
              hintText: "********",
              controller: controller.passwordController,
            ),
            InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.forgotPasswordScreen);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: AppTextStyles.regularStyle,
                ),
              ),
            ),
            8.vertical,
            Obx(
                  () => AppButton(
                text: "Login",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.handleSignIn(
                    email: controller.emailController.text,
                    password: controller.passwordController.text,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => controller.goToRegisterScreen(userRole!),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Don\'t have an account? ',
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.mainColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Create Account',
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontFamily: AppFonts.publicSansBold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
