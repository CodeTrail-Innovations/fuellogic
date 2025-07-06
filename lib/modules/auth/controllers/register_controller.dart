import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/register_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyIdController = TextEditingController();

  RxBool isTermsAccepted = false.obs;
  final isLoading = false.obs;
  final isValidatingCompany = false.obs;

  Map<String, dynamic>? currentUserData;

  void goToLoginScreen(UserRole role) {
    Get.toNamed(AppRoutes.loginScreen, arguments: role);
  }

  Future<void> validateCompanyId() async {
    final companyUid = companyIdController.text.trim();
    log('[RegisterController] Validating company ID: $companyUid');
    if (companyUid.isEmpty) {
      log('Company ID is empty - skipping validation');
      return;
    }

    isValidatingCompany.value = true;
    final registerRepo = RegisterRepoImpl();

    try {
      bool isValid = await registerRepo.validateCompanyId(companyUid);
      if (!isValid) {
        DialogUtils.showAnimatedDialog(
          type: DialogType.error,
          title: 'Invalid Company ID',
          message:
              'The company ID (UID) you entered is not valid. Please check with your company administrator.',
        );
      }
    } catch (e) {
      log('Error validating company UID: $e');
    } finally {
      isValidatingCompany.value = false;
    }
  }

  Future<void> handleSignUp({required UserRole role}) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final companyId = companyIdController.text.trim();

    log('[RegisterController] Handling signup for role: ${role.value}');
    log('Name: $name, Email: $email, CompanyID: $companyId');

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Name, email, and password are required',
      );
      return;
    }

    if (role == UserRole.driver && companyId.isEmpty) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Company ID is required for driver registration',
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
        companyId: companyId,
      );

      await fetchCurrentUserData();
    } catch (e) {
      log('Error during sign-up: $e');
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
    companyIdController.dispose();
    super.onClose();
  }
}
