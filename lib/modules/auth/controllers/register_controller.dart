import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/core/routes/app_router.dart';
import 'package:fuellogic/helper/extensions/string_extensions.dart';
import 'package:fuellogic/modules/auth/repositories/implementations/register_repo_impl.dart';
import 'package:fuellogic/utils/dialog_utils.dart';
import 'package:get/get.dart';

import '../../../data_manager/repositories/auth_repository/auth_repository.dart';
import '../../../helper/services/auth_service.dart';
import '../../../helper/services/snackbar_service.dart';

class RegisterController extends GetxController {

  final AuthRepository _authRepository = AuthRepository();
  final RxBool isLoading = false.obs;
  final _authService = Get.find<AuthService>();
  final RxString selectedRole = 'company'.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyIdController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();


  RxBool isTermsAccepted = false.obs;
  final isValidatingCompany = false.obs;
  final isConsent = false.obs;
  final errorMessage = ''.obs;
  late User user;

  Map<String, dynamic>? currentUserData;


  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < 5) {
      return 'Please enter a valid address';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    if (value.length < 2) {
      return 'Please enter a valid city';
    }
    return null;
  }

  String? validateOrganization(String? value) {
    if (value == null || value.isEmpty) {
      return 'Organization/Company is required';
    }
    if (value.length < 2) {
      return 'Please enter a valid Company Name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 8) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Form validation
  bool _validateSignupForm() {
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);
    final confirmPasswordError = validateConfirmPassword(confirmPasswordController.text);
    final nameError = validateName(nameController.text);
    final phoneError = validatePhoneNumber(phoneNumberController.text);
    final addressError = validateAddress(addressController.text);
    // final cityError = validateCity(cityController.text);
    final organizationError = validateOrganization(companyController.text);

    if (emailError != null) {
      SnackbarService.showError(emailError);
      return false;
    }
    if (passwordError != null) {
      SnackbarService.showError(passwordError);

      return false;
    }
    if (confirmPasswordError != null) {
      SnackbarService.showError(confirmPasswordError);
      return false;
    }
    if (nameError != null) {
      SnackbarService.showError(nameError);

      return false;
    }
    if (phoneError != null) {
      SnackbarService.showError(phoneError);

      return false;
    }
    // if (cityError != null) {
    //   SnackbarService.showError(cityError);
    //
    //   return false;
    // }
    if (addressError != null) {
      SnackbarService.showError(addressError);

      return false;
    }
    if (organizationError != null) {
      SnackbarService.showError(organizationError);

      return false;
    }

    return true;
  }


  bool _validateLoginForm() {
    final emailError = validateEmail(emailController.text);
    final passwordError = validatePassword(passwordController.text);

    if (emailError != null) {
      SnackbarService.showError(emailError);

      return false;
    }
    if (passwordError != null) {
      SnackbarService.showError(passwordError);

      return false;
    }
    return true;
  }


  bool _validateForgotPasswordForm() {
    final emailError = validateEmail(emailController.text);
    if (emailError != null) {
      Get.snackbar('Error', emailError, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red[100]);
      return false;
    }
    return true;
  }


  void updateRole(String role){
    selectedRole.value = role;
  }

  Future<void> login() async {
    if (!_validateLoginForm()) {
      SnackbarService.showError('Please fix the validation errors');
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      // final user = await _authRepository.signInWithEmailAndPassword(email:email, password: password);
      final user = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        SnackbarService.showSuccess('Logged in successfully');
        // navigateToAdminMainScreen();
        _navigateToHomeScreen(user.role);

      }
    } on FirebaseAuthException catch (e) {
      final readableMessage = e.toString().readableAuthError;
      // final readableMessage = _getReadableErrorMessage(e.code);
      SnackbarService.showError('Login Failed: $readableMessage');
    }
    catch (e) {
      final readableMessage = e.toString().readableAuthError;
      // final readableMessage = _getReadableErrorMessage(e.toString());
      SnackbarService.showError('Login Failed: $readableMessage');
    }  finally {
      isLoading.value = false;
    }
  }


  Future<void> signup() async {
    if (!_validateSignupForm()) {
      SnackbarService.showError('Please fix the validation errors');
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {

      final companyLower = companyController.text.trim().toLowerCase();
      final companyKeywords =  companyController.text
          .trim()
          .toLowerCase()
          .split(RegExp(r'\s+'))
          .where((w) => w.isNotEmpty)
          .toList();

      // Prepare additional data for user document.
      Map<String, dynamic> additionalData = {
        'address': addressController.text.trim(),
        'organization': companyController.text.trim(),
        'isVerified': false,
        'companyLower': companyLower,
        'companyKeywords': companyKeywords,
      };




      // Sign up the user with the provided data.
      final user = await _authService.signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        role: selectedRole.value,
        additionalData: additionalData,
      );

      if (user != null) {
        SnackbarService.showSuccess('Account created successfully');
        await Future.delayed(const Duration(milliseconds: 500));
        _navigateToHomeScreen(user.role);
      } else {
        SnackbarService.showError('Error Signing-Up\nPlease recheck your details');

      }
    } catch (e) {
      String errorMsg = e.toString().readableAuthError;
      errorMessage.value = errorMsg;
    } finally {
      isLoading.value = false;
    }
  }



  void navigateToAdminMainScreen() {
    Get.offAllNamed(AppRoutes.adminMainScreen);
  }
  void _navigateToHomeScreen(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        Get.offAllNamed(AppRoutes.adminMainScreen);
        break;
      case 'company':
        Get.offAllNamed(AppRoutes.companyMainScreen);
        break;
      default:
        Get.offAllNamed(AppRoutes.welcome);
        break;
    }
  }

  Future<void> resetPassword() async {
    if (!_validateForgotPasswordForm()) {
      SnackbarService.showError('Please fix the validation errors');

      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      await _authService.sendPasswordResetEmail(emailController.text.trim());
      SnackbarService.showSuccess('Password reset link has been sent to your email');
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.back();
    } catch (e) {
      String errorMsg = e.toString().readableAuthError;
      SnackbarService.showSuccess('An error occurred: $errorMsg');
      errorMessage.value = errorMsg;
    } finally {
      isLoading.value = false;
    }
  }


  void goToLoginScreen() {
    Get.toNamed(AppRoutes.loginScreen);
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRoutes.registerScreen);
  }
  //
  // Future<void> validateCompanyId() async {
  //   final companyUid = companyIdController.text.trim();
  //   log('[RegisterController] Validating company ID: $companyUid');
  //   if (companyUid.isEmpty) {
  //     log('Company ID is empty - skipping validation');
  //     return;
  //   }
  //
  //   isValidatingCompany.value = true;
  //   final registerRepo = RegisterRepoImpl();
  //
  //   try {
  //     bool isValid = await registerRepo.validateCompanyId(companyUid);
  //     if (!isValid) {
  //       DialogUtils.showAnimatedDialog(
  //         type: DialogType.error,
  //         title: 'Invalid Company ID',
  //         message:
  //             'The company ID (UID) you entered is not valid. Please check with your company administrator.',
  //       );
  //     }
  //   } catch (e) {
  //     log('Error validating company UID: $e');
  //   } finally {
  //     isValidatingCompany.value = false;
  //   }
  // }
  //
  // Future<void> handleSignUp({required UserRole role}) async {
  //   final name = nameController.text.trim();
  //   final email = emailController.text.trim();
  //   final password = passwordController.text.trim();
  //   final companyId = companyIdController.text.trim();
  //
  //   log('[RegisterController] Handling signup for role: ${role.value}');
  //   log('Name: $name, Email: $email, CompanyID: $companyId');
  //
  //   if (name.isEmpty || email.isEmpty || password.isEmpty) {
  //     DialogUtils.showAnimatedDialog(
  //       type: DialogType.error,
  //       title: 'Error',
  //       message: 'Name, email, and password are required',
  //     );
  //     return;
  //   }
  //
  //   if (role == UserRole.driver && companyId.isEmpty) {
  //     DialogUtils.showAnimatedDialog(
  //       type: DialogType.error,
  //       title: 'Error',
  //       message: 'Company ID is required for driver registration',
  //     );
  //     return;
  //   }
  //
  //   if (!isTermsAccepted.value) {
  //     DialogUtils.showAnimatedDialog(
  //       type: DialogType.error,
  //       title: 'Error',
  //       message: 'Please accept terms and conditions',
  //     );
  //     return;
  //   }
  //
  //   isLoading.value = true;
  //   final registerRepo = RegisterRepoImpl();
  //
  //   try {
  //     await registerRepo.userSignUp(
  //       name: name,
  //       email: email,
  //       password: password,
  //       role: role,
  //       companyId: companyId,
  //     );
  //
  //     await fetchCurrentUserData();
  //   } catch (e) {
  //     log('Error during sign-up: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<void> fetchCurrentUserData() async {
  //   try {
  //     final registerRepo = RegisterRepoImpl();
  //     currentUserData = await registerRepo.getCurrentUserData();
  //     if (currentUserData != null) {
  //       log('User Data: $currentUserData');
  //     } else {
  //       log('Failed to fetch user data');
  //     }
  //   } catch (e) {
  //     log('Error fetching user data: $e');
  //   }
  // }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    companyIdController.dispose();
    super.onClose();
  }
}
