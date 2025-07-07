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

class RegisterScreen extends StatelessWidget {
  // final UserRole? userRole;
  RegisterScreen({super.key});
      // : userRole = Get.arguments

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
                    spacing: 16,
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
                      AppField(
                        hintText: "e.g Dina Adam",
                        controller: controller.nameController,
                        validator: controller.validateName,
                        capitalization: TextCapitalization.words,
                      ),
                      Text("Email", style: AppTextStyles.regularStyle),
                      AppField(
                        hintText: "someone@mail.com",
                        controller: controller.emailController,
                        validator: controller.validateEmail,
                      ),
                      Text("Password", style: AppTextStyles.regularStyle),
                      AppField(
                        isPasswordField: true,
                        hintText: "*********",
                        controller: controller.passwordController,
                      ),
                      Text("Confirm Password", style: AppTextStyles.regularStyle),
                      AppField(
                        hintText: "*********",
                        isPasswordField: true,
                        controller: controller.confirmPasswordController,
                        validator: controller.validateConfirmPassword,
                      ),
                      Text("Company Name", style: AppTextStyles.regularStyle),
                      AppField(
                        hintText: 'e.g Star Traders',
                        controller: controller.companyController,
                        validator: controller.validateOrganization,
                        capitalization: TextCapitalization.words,
                      ),
                      Text("Address", style: AppTextStyles.regularStyle),
                      AppField(
                        hintText: 'e.g Office 12A, City Mall, Johar Town, Lahore',
                        controller: controller.addressController,
                        validator: controller.validateAddress,
                        capitalization: TextCapitalization.sentences,
                      ),
                      Text("Phone Number", style: AppTextStyles.regularStyle),
                      AppField(
                        hintText: '03012345678',
                        controller: controller.phoneNumberController,
                        validator: controller.validatePhoneNumber,
                      ),
                      // if (userRole == UserRole.driver) ...[
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Enter Company ID",
                      //         style: AppTextStyles.regularStyle,
                      //       ),
                      //       16.vertical,
                      //       AppFeild(
                      //         hintText: "eg., q2tM15S7VnYTfs",
                      //         controller: controller.companyIdController,
                      //       ),
                      //       Obx(
                      //         () =>
                      //             controller.isValidatingCompany.value
                      //                 ? Padding(
                      //                   padding: const EdgeInsets.only(
                      //                     top: 8.0,
                      //                   ),
                      //                   child: Row(
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 16,
                      //                         height: 16,
                      //                         child: CircularProgressIndicator(
                      //                           strokeWidth: 2,
                      //                           color: AppColors.primaryColor,
                      //                         ),
                      //                       ),
                      //                       8.horizontal,
                      //                       Text(
                      //                         "Validating company ID...",
                      //                         style: AppTextStyles.captionStyle
                      //                             .copyWith(
                      //                               color:
                      //                                   AppColors.primaryColor,
                      //                             ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //                 : const SizedBox.shrink(),
                      //       ),
                      //       16.vertical,
                      //     ],
                      //   ),
                      // ],
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
                      Obx(
                        () => AppButton(
                          text: "Register",
                          isLoading: controller.isLoading.value,
                          onPressed:
                              () => controller.signup(),
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
