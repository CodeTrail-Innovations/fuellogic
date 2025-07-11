import 'dart:developer';

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

import '../../../widgets/custom_appbar.dart';

class RegisterScreen extends StatelessWidget {
  final UserRole? userRole;
  RegisterScreen({super.key}) : userRole = Get.arguments;

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    log("User Role: $userRole");

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          isSimple: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.vertical,
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
                    Text(
                      "Fill in your details to get fuel better!",
                      style: AppTextStyles.regularStyle,
                    ),
                    Text("Full Name", style: AppTextStyles.regularStyle),
                    AppFeild(
                      hintText: "e.g Dina Adam",
                      controller: controller.nameController,
                    ),
                    Text("Email", style: AppTextStyles.regularStyle),
                    AppFeild(
                      hintText: "someone@mail.com",
                      controller: controller.emailController,
                    ),
                    if (userRole == UserRole.driver)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: AppTextStyles.regularStyle,
                                ),

                                AppFeild(
                                  isPasswordField: true,
                                  hintText: "*********",
                                  controller: controller.passwordController,
                                ),
                              ],
                            ),
                          ),
                          12.horizontal,
                          Expanded(
                            child: Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company ID",
                                  style: AppTextStyles.regularStyle,
                                ),
                                AppFeild(
                                  hintText: "eg., q2tM15S7VnYTfs",
                                  controller: controller.companyIdController,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          Text("Password", style: AppTextStyles.regularStyle),
                          AppFeild(
                            isPasswordField: true,
                            hintText: "*********",
                            controller: controller.passwordController,
                          ),
                        ],
                      ),

                    if (userRole == UserRole.driver)
                      Obx(
                        () =>
                            controller.isValidatingCompany.value
                                ? Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    8.horizontal,
                                    Text(
                                      "Validating company ID...",
                                      style: AppTextStyles.captionStyle
                                          .copyWith(
                                            color: AppColors.primaryColor,
                                          ),
                                    ),
                                  ],
                                )
                                : const SizedBox.shrink(),
                      ),
                    SizedBox(
                      height: 20,
                      child: Row(
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
                            "Fuelogic",
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => AppButton(
                        text: "Register",
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
              onTap: () => controller.goToLoginScreen(userRole!),
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
    );
  }
}
