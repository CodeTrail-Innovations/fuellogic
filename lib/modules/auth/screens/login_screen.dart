import 'package:flutter/material.dart';
import 'package:fuellogic/config/app_textstyle.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_button.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/core/constant/app_field.dart';
import 'package:fuellogic/core/constant/app_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  // final controller = Get.put(LoginController());

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
                      Text(
                        "Welcome Back",
                        style: AppTextStyles.extraLargeStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      16.vertical,
                      Text(
                        "You know the drills",
                        style: AppTextStyles.regularStyle,
                      ),
                      24.vertical,
                      Text("Email", style: AppTextStyles.regularStyle),
                      16.vertical,
                      AppFeild(
                        hintText: "someone@mail.com",
                        // controller: controller.emailController,
                      ),
                      Text("Password", style: AppTextStyles.regularStyle),
                      16.vertical,
                      AppFeild(
                        isPasswordField: true,
                        hintText: "Enter password",
                        // controller: controller.passwordController,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password?",
                          style: AppTextStyles.regularStyle,
                        ),
                      ),
                      24.vertical,
                      AppButton(
                        text: "Login",
                        // isLoading: controller.isLoading.value,
                        onPressed: () {
                          // controller.handleSignUp(
                          //    controller.emailController.text,
                          //   controller.passwordController.text,
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: controller.goToRegisterScreen,
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
            ],
          ),
        ),
      ),
    );
  }
}
