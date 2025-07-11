import 'package:flutter/material.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../../config/app_textstyle.dart';
import '../../../core/constant/app_button.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_field.dart';
import 'add_new_admin_controller.dart';

class AddNewAdminScreen extends StatelessWidget {
  AddNewAdminScreen({super.key});

  final controller = Get.put(AddNewAdminController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppBar(
          isSimple: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [

                Row(
                  children: [
                    Text("Add New ", style: AppTextStyles.extraLargeStyle),
                    Text(
                      "Admin",
                      style: AppTextStyles.extraLargeStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Fill in detail to register Admin!",
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
                Text("Password", style: AppTextStyles.regularStyle),
                AppFeild(
                  isPasswordField: true,
                  hintText: "*********",
                  controller: controller.passwordController,
                ),

                Obx(
                      () => AppButton(
                    text: "Add Admin",
                    isLoading: controller.isLoading.value,
                    onPressed:
                        () => controller.handleSignUp(),
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
