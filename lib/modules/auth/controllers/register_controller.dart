import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/core/constant/custom_bottom_bar.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/register_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final comapanyIdController = TextEditingController();
  RxBool isTermsAccepted = false.obs;
  final isLoading = false.obs;
  Map<String, dynamic>? currentUserData;

  void goToLoginScreen(UserRole role) {
    Get.toNamed(AppRouter.loginScreen, arguments: role);
  }

  Future<void> handleSignUp({required UserRole role}) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final comapanyId = comapanyIdController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        comapanyId.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'All fields are required',
      );
      return;
    }

    if (!isTermsAccepted.value) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Please accept terms and conditions',
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
        role: role,
        comapanyId: comapanyId,
      );

      DialogUtils.showAnimatedDialog(
        type: DialogType.success,
        title: 'Success',
        message: 'Registration successful!',
      );

      Get.off(() => CustomBottomBar());

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
