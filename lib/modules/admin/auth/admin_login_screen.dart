import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/modules/admin/auth/admin_login_controller.dart';
import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_button.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_field.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/custom_appbar.dart';

class AdminLoginScreen extends StatelessWidget {
  AdminLoginScreen({super.key});

  final controller = Get.put(AdminLoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                "Welcome Back",
                style: AppTextStyles.extraLargeStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                "Access Admin Panel",
                style: AppTextStyles.regularStyle,
              ),
              8.vertical,
              Text("Email", style: AppTextStyles.regularStyle),
              AppFeild(
                hintText: "admin@fuelogic.com",
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
      ),
    );
  }
}
