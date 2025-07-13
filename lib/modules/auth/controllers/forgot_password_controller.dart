import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dialog_utils.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController();

  final isLoading = false.obs;




  Future<void> sendPasswordResetEmail() async {
    final email = emailController.text.trim();

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      DialogUtils.showAnimatedDialog(
        type: DialogType.error,
        title: 'Error',
        message: 'Please enter a valid email',
      );
      return;
    }

    isLoading.value = true;


    try {
      await _auth.sendPasswordResetEmail(email: email);

      DialogUtils.showAnimatedDialog(
        type: DialogType.success,
        title: 'Success',
        message: 'If this email matches our records, password reset link will be sent to your email.',
        positiveButtonText: 'Okay',
      );

      clearField();

    } catch (e) {
      log('Error during sign-up: $e');
    } finally {
      isLoading.value = false;
    }



  }

  void clearField(){
    emailController.clear();
  }


}