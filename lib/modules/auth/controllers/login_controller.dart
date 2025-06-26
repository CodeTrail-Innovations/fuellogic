import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/login_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isLoading = false.obs;
  final LoginRepoImpl loginRepo = LoginRepoImpl();

  void goToRegisterScreen() {
    Get.toNamed(AppRouter.registerScreen);
  }

  Future<void> handleSignIn({required String email, required String password}) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Please enter both email and password',
      );
      return;
    }

    isLoading.value = true;
    try {
      await loginRepo.userSignIn(email: email, password: password);
    } catch (e) {
      log('Error during sign-in: $e');
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Sign-In Failed',
        message: 'An unexpected error occurred. Please try again later.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
