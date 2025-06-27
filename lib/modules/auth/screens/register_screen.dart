import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/auth/controllers/register_controller.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final UserRole? userRole;
  RegisterScreen({super.key}) : userRole = Get.arguments;
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.whiteColor,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      24.vertical,
                      Row(
                        children: [
                          Text("Join ", style: AppTextStyles.extraLargeStyle),
                          Text(
                            "Fuelogic",
                            style: AppTextStyles.extraLargeStyle.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      16.vertical,
                      Text(
                        "Fill in your details to get fuel better!",
                        style: AppTextStyles.regularStyle,
                      ),
                      24.vertical,
                      Text("Full Name", style: AppTextStyles.regularStyle),
                      16.vertical,
                      AppFeild(
                        hintText: "e.g Dina Adam",
                        controller: controller.nameController,
                      ),
                      Text("Email", style: AppTextStyles.regularStyle),
                      16.vertical,

                      AppFeild(
                        hintText: "someone@mail.com",
                        controller: controller.emailController,
                      ),

                      Text("Password", style: AppTextStyles.regularStyle),
                      16.vertical,
                      AppFeild(
                        isPasswordField: true,
                        hintText: "Enter password",
                        controller: controller.passwordController,
                      ),
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.isTermsAccepted.value,
                              onChanged: (value) {
                                controller.isTermsAccepted.value =
                                    value ?? false;
                              },
                              activeColor: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "I agree to the T&C ",
                            style: AppTextStyles.regularStyle,
                          ),
                          Text(
                            "Fuellogic",
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      24.vertical,
                      Obx(
                        () => AppButton(
                          text: "Sign Up",
                          isLoading: controller.isLoading.value,
                          onPressed:
                              () => controller.handleSignUp(role: userRole!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.goToLoginScreen(),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign In',
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
            ],
          ),
        ),
      ),
    );
  }
}
