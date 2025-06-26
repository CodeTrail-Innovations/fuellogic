import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/register_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isTermsAccepted = false.obs;
  final isLoading = false.obs;
  Map<String, dynamic>? currentUserData;

  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  Future<void> handleSignUp(String name, String email, String password) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'All fields are required',
      );
      return;
    }

    isLoading.value = true;
    final registerRepo = RegisterRepoImpl();

    try {
      await registerRepo.userSignUp(
        name: name,
        email: email,
        password: password,
      );

      DialogUtils.showAnimatedDialog(
        type: DialogType.success,
        title: 'Success',
        message: 'Registration successful!',
        positiveButtonText: 'Continue',
        positiveButtonAction: () {
          Get.offNamed(AppRouter.loginScreen);
        },
      );

      await fetchCurrentUserData();
    } catch (e) {
      log('Error during sign-up: $e');

      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Registration Failed',
        message: 'An unexpected error occurred. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCurrentUserData() async {
    try {
      final registerRepo = RegisterRepoImpl();
      currentUserData = await registerRepo.getCurrentUserData();

      if (currentUserData != null) {
        log('User Data: $currentUserData');
      } else {
        log('Failed to fetch user data');
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
