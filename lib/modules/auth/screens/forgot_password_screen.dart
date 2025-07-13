import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/modules/auth/controllers/forgot_password_controller.dart';
import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_button.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_field.dart';
import '../../../widgets/custom_appbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password?",
              style: AppTextStyles.largeStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 28
              ),
            ),
            Text(
              "Enter your email to continue.",
              style: AppTextStyles.regularStyle,
            ),
            8.vertical,
            Text("Email", style: AppTextStyles.regularStyle),
            AppFeild(
              hintText: "someone@mail.com",
              controller: controller.emailController,
            ),

            16.vertical,
            Obx(
                  () => AppButton(
                text: "Submit",
                isLoading: controller.isLoading.value,
                onPressed: () {
                  controller.sendPasswordResetEmail();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
